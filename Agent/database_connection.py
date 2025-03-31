# database_connection.py
import mysql.connector
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

class DatabaseConnector:
    def __init__(self):
        # Fetch credentials from environment variables
        self.host = os.getenv("DB_HOST", "localhost")
        self.user = os.getenv("DB_USER", "root")
        self.password = os.getenv("DB_PASSWORD", "your_password")
        self.database = os.getenv("DB_NAME", "Kap")
        
        # Establish a connection to the MySQL database
        self.connection = mysql.connector.connect(
            host=self.host,
            user=self.user,
            password=self.password,
            database=self.database
        )
        self.cursor = self.connection.cursor()

    def execute_query(self, query):
        """Executes a SQL query and returns the result."""
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def close_connection(self):
        """Closes the cursor and connection."""
        self.cursor.close()
        self.connection.close()
