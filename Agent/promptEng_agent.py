import openai
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
from langchain_community.llms import OpenAI
from langchain.prompts import PromptTemplate
from database_connection import DatabaseConnector
from schema_loader import split_schema_into_chunks  # Import the chunking function

# Set up OpenAI API key
openai.api_key = "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"


class PromptEngineeringAgent:
    def __init__(self, db_connector, openai_connector, schema_dict):
        self.db_connector = db_connector
        self.openai_connector = openai_connector
        self.schema = schema_dict
        # Initialize LLM using OpenAI from langchain-community
        self.llm = OpenAI(api_key="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")

    def get_embeddings(self, text):
        """Get embeddings for the input text using OpenAI's embedding API."""
        response = openai.Embedding.create(input=[text], model="text-embedding-ada-002")
        return np.array(response['data'][0]['embedding'])

    def filter_schema_using_semantic_search(self, user_query):
        """Filter schema based on semantic similarity to user query."""
        # Get the embedding for the user query
        query_embedding = self.get_embeddings(user_query)

        relevant_tables = []
        similarities = {}

        # Loop through each table and compute similarity to the user query
        for table, columns in self.schema.items():
            # Combine the table name and columns into one string for embedding comparison
            table_description = f"{table} with columns: {', '.join(columns)}"
            table_embedding = self.get_embeddings(table_description)

            # Compute cosine similarity between the query and the table description
            similarity = cosine_similarity([query_embedding], [table_embedding])[0][0]
            similarities[table] = similarity

        # Sort tables by similarity to the query
        sorted_tables = sorted(similarities.items(), key=lambda x: x[1], reverse=True)
        
        # Select the top relevant tables based on similarity threshold
        threshold = 0.5  # You can adjust this threshold based on the results
        for table, similarity in sorted_tables:
            if similarity > threshold:
                relevant_tables.append(table)

        # Return filtered schema for relevant tables
        filtered_schema = {table: self.schema[table] for table in relevant_tables if table in self.schema}
        return filtered_schema

    def design_prompt(self, user_query):
        """Design and optimize the prompt for LLM to generate an accurate SQL query."""
        if not user_query or user_query.strip() == "":
            raise ValueError("User query cannot be empty.")

        # Basic prompt design
        prompt = f"Translate the following query into an optimized SQL statement: {user_query}"
        optimized_prompt = self.optimize_prompt(prompt)
        return optimized_prompt

    def optimize_prompt(self, prompt):
        """Optimize the prompt based on schema knowledge."""
        # Adding schema context into the prompt
        schema_context = "\n".join([f"{table}: {', '.join(columns)}" for table, columns in self.schema.items()])
        prompt = f"Here is the schema of the database:\n{schema_context}\n\n{prompt}"
        return prompt

    def generate_sql(self, user_query):
        """Generate an optimized SQL query using OpenAI based on schema chunks."""
        # Filter schema based on semantic search
        filtered_schema = self.filter_schema_using_semantic_search(user_query)
        
        # Now, proceed to chunk the filtered schema and generate SQL queries
        chunked_schema = split_schema_into_chunks(filtered_schema, chunk_size=3)
        
        sql_queries = []
        for chunk in chunked_schema:
            schema_context = "\n".join([f"{table}: {', '.join(columns)}" for table, columns in chunk.items()])
            full_prompt = f"Here is the relevant schema of the database:\n{schema_context}\n\n{user_query}"
            
            prompt_template = PromptTemplate(input_variables=["query", "schema_context"], template=full_prompt)
            chain = prompt_template | self.llm
            sql_query = chain.invoke({"query": user_query, "schema_context": chunk})
            sql_queries.append(sql_query)

        # Combine all queries into one
        full_sql_query = " ".join(sql_queries)
        return full_sql_query

    def execute_sql_query(self, user_query):
        """Generate and execute the SQL query, and fetch results."""
        # Generate SQL using schema chunks
        sql_query = self.generate_sql(user_query)

        if sql_query:
            try:
                # Execute the combined SQL query
                results = self.db_connector.execute_query(sql_query)
                
                return {
                    "generated_sql": sql_query,
                    "query_results": results
                }
            except Exception as e:
                print(f"Error executing query: {e}")
                return {"generated_sql": sql_query, "query_results": None}
        
        return {"generated_sql": None, "query_results": None}
