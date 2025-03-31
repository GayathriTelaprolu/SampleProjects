from phi.agent import Agent
from phi.model.groq import Groq
from dotenv import load_dotenv

load_dotenv()

# Define the tool for handling conversations
def conversation_tool(conversation: str) -> str:
    """
    Processes a conversation between the client and CEO and extracts requirements.

    Args:
        conversation (str): The full conversation.

    Returns:
        str: Extracted business requirements in a structured format.
    """
    # Placeholder for processing the conversation
    # In production, you can use NLP libraries or custom logic
    requirements = {
        "Features": [],
        "Design Preferences": [],
        "Functional Requirements": []
    }

    for line in conversation.split("\n"):
        if "feature" in line.lower() or "need" in line.lower():
            requirements["Features"].append(line)
        elif "design" in line.lower() or "theme" in line.lower():
            requirements["Design Preferences"].append(line)
        elif "should" in line.lower() or "must" in line.lower():
            requirements["Functional Requirements"].append(line)

    # Format as a BRD
    brd = "# Business Requirements Document (BRD)\n\n"
    for section, items in requirements.items():
        brd += f"## {section}\n"
        brd += "\n".join([f"- {item}" for item in items]) + "\n\n"
    return brd

# Define the agent
agent = Agent(
    model=Groq(id="llama-3.3-70b-versatile"),
    tools=[conversation_tool],
    instructions=[
        "Process conversations between the Client and CEO to extract business requirements.",
        "Generate a structured Business Requirements Document (BRD) with sections: Features, Design Preferences, Functional Requirements.",
        "Use markdown formatting for the BRD.",
        "If you need to process a conversation, call the conversation_tool."
    ],
    show_tool_calls=True,
    markdown=True,
    debug_mode=True,
)

# Simulated conversation between Client and CEO
conversation = """
Client: We need an e-commerce system with a user-friendly UI.
Client: It should support a shopping cart, product search, and secure payment.
Client: We prefer a modern design with a blue and white color theme.
CEO: We can implement the shopping cart and product search.
CEO: The secure payment will integrate with popular gateways like PayPal.
CEO: For the UI, we can design a modern theme as per your preference.
"""

# Generate BRD
agent.print_response(
    f"Process the following conversation to generate a BRD:\n{conversation}",
    stream=True
)
 