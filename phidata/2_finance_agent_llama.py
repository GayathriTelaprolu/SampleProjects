"""Run `pip install yfinance` to install dependencies."""

from phi.agent import Agent
from phi.model.groq import Groq
from phi.tools.duckduckgo import DuckDuckGo
from dotenv import load_dotenv

load_dotenv()


web_agent = Agent(
    name="Web Agent",
    role="Search the web for information",
    model=Groq(id="llama-3.3-70b-versatile"),
    tools=[DuckDuckGo()],
    instructions=["Always include sources"],
    show_tool_calls=True,
    markdown=True,
)


try:
    web_agent.print_response("serach for the lastest jobs for dataanalyst", stream=True)
except Exception as e:
    print("Error occurred:", str(e))
    if hasattr(e, "failed_generation"):
        print("Failed generation details:", e.failed_generation)
