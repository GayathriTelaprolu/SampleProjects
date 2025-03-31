from database_connection import DatabaseConnector
from openai_api_connector import OpenAIConnector
from promptEng_agent import PromptEngineeringAgent
from schema_loader import load_schema_from_file  # Import the function

# Load schema from file using the function from schema_loader.py
schema_file_path = "tables_columns.txt"  # Update this to the actual file path
schema_dict = load_schema_from_file(schema_file_path)

# Set up Database Connection
db_connector = DatabaseConnector()

# Set up OpenAI API Connector
openai_connector = OpenAIConnector(api_key="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")

# Create the Prompt Engineering Agent
agent = PromptEngineeringAgent(db_connector=db_connector, openai_connector=openai_connector, schema_dict=schema_dict)

# Example Usage: Provide a user query
user_query = "Retrieve all off-dates for the calendar with calendarId 1001."
result = agent.execute_sql_query(user_query)

# Display the generated SQL query and results
print(f"Generated SQL Query: {result['generated_sql']}")
if result['query_results']:
    print("Query Results:")
    for row in result['query_results']:
        print(row)
else:
    print("No results found or an error occurred.")

# Close the database connection
db_connector.close_connection()
