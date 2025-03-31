import openai
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Retrieve the OpenAI API key from environment variables
openai_api_key = os.getenv("OPENAI_API_KEY")

if not openai_api_key:
    raise ValueError("OpenAI API key is not set in the environment variables!")

# Initialize OpenAI API client
class OpenAIConnector:
    def __init__(self, api_key):
        openai.api_key = api_key

    def generate_sql(self, prompt):
        """Generate SQL query using OpenAI GPT model via the chat endpoint."""
        if not prompt or prompt.strip() == "":
            raise ValueError("Prompt cannot be empty.")

        try:
            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",  # Or use gpt-4
                messages=[
                    {"role": "system", "content": "You are a helpful assistant that generates SQL queries."},
                    {"role": "user", "content": prompt}
                ],
                max_tokens=150,
                temperature=0.5
            )
            sql_query = response['choices'][0]['message']['content'].strip()
            return sql_query
        except Exception as e:
            print(f"Error generating SQL with OpenAI: {e}")
            return None
