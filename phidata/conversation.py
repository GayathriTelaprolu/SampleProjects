import os
from google.cloud import aiplatform
from phi.agent import Agent, RunResponse
from phi.model.vertexai import Gemini

# Set the GOOGLE_APPLICATION_CREDENTIALS environment variable to the path of your service account JSON file
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = r"C:/Users/Public/genai1/GenAi/agents_finance/jsonfile.json"  # Replace with your file path

# Initialize the AI platform with the project ID and location
aiplatform.init(project="handy-outpost-445916-d2", location="us-central1")

# Initialize the Gemini model (remove the API key here because it's handled by the service account credentials)
agent = Agent(
    model=Gemini(id="gemini-1.5-flash"),
    markdown=True
)

# Get the response in a variable
run: RunResponse = agent.run("Share a 2 sentence horror story.")
print(run.content)

# Alternatively, print the response directly on the terminal
# agent.print_response("Share a 2 sentence horror story.")
