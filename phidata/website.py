from phi.agent import Agent
from phi.tools.website import WebsiteTools
from phi.model.groq import Groq
from dotenv import load_dotenv

load_dotenv()
agent = Agent(tools=[WebsiteTools()],
              model=Groq(id="llama-3.3-70b-versatile"),
               show_tool_calls=True)
agent.print_response("Search web page: 'https://docs.phidata.com/introduction'", markdown=True)
