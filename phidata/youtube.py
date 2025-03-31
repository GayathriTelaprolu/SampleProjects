from phi.agent import Agent
from phi.model.groq import Groq
from phi.tools.youtube_tools import YouTubeTools

# Set your GROQ API key here
GROQ_API_KEY = "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"  # Replace with your actual API key

# Initialize the Agent with YouTubeTools and the Groq model
agent = Agent(
    tools=[YouTubeTools()],
    model=Groq(id="llama-3.3-70b-versatile", api_key=GROQ_API_KEY),  # Pass the API key here
    show_tool_calls=True,
    description="You are a YouTube agent. Obtain the captions of a YouTube video and answer questions.",
)

# Use the agent to summarize the video
agent.print_response(
    "Summarize this video https://www.youtube.com/watch?v=gHXENP57beg ",
    markdown=True,
)
