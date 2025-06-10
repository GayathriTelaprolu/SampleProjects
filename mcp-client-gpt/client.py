import asyncio
import os
import sys
import json
from typing import Optional
from contextlib import AsyncExitStack
from dotenv import load_dotenv
import openai

from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

class MCPClient:
    def __init__(self):
        self.session: Optional[ClientSession] = None
        self.exit_stack = AsyncExitStack()

    async def connect_to_server(self, server_script_path: str):
        if not server_script_path.endswith('.py'):
            raise ValueError("Server script must be a .py file")

        server_params = StdioServerParameters(
            command="python",
            args=[server_script_path]
        )

        stdio_transport = await self.exit_stack.enter_async_context(stdio_client(server_params))
        self.stdio, self.write = stdio_transport
        self.session = await self.exit_stack.enter_async_context(ClientSession(self.stdio, self.write))
        await self.session.initialize()

        tools = await self.session.list_tools()
        print("✅ Connected to server with tools:", [t.name for t in tools.tools])

    async def process_query(self, query: str) -> str:
        messages = [
            {"role": "system", "content": "You are a helpful assistant with access to tools."},
            {"role": "user", "content": query}
        ]

        # List tools from MCP server
        tool_list = await self.session.list_tools()
        available_functions = [{
            "name": tool.name,
            "description": tool.description,
            "parameters": tool.inputSchema
        } for tool in tool_list.tools]

        # Initial GPT call with tool list
        response = openai.ChatCompletion.create(
            model="gpt-4-0613",
            messages=messages,
            functions=available_functions,
            function_call="auto"
        )

        choice = response.choices[0].message
        final_text = []

        if "function_call" in choice:
            func_call = choice["function_call"]
            func_name = func_call.get("name")
            arguments = func_call.get("arguments")

            try:
                args = json.loads(arguments) if isinstance(arguments, str) else arguments
            except Exception as e:
                return f"Error parsing tool arguments: {e}"

            # Call tool from MCP server
            result = await self.session.call_tool(func_name, args)

            # Print result type for debugging
            print("TOOL RESULT TYPE:", type(result.content))

            # Append tool call and tool result to messages
            messages.append({
                "role": "assistant",
                "content": None,
                "function_call": func_call
            })
            messages.append({
                "role": "function",
                "name": func_name,
                "content": str(result.content)  # ✅ Convert to string to avoid serialization errors
            })

            # Second GPT call with tool result
            followup = openai.ChatCompletion.create(
                model="gpt-4-0613",
                messages=messages
            )
            final_text.append(followup.choices[0].message.content)
        else:
            return "⚠️ This assistant only responds to supported tool-based queries. Please ask a weather-related question."

        return "\n".join(final_text)

    async def chat_loop(self):
        print("\n🤖 GPT-MCP Client Started!")
        print("Type your queries or 'quit' to exit.")
        while True:
            query = input("\nAsk: ").strip()
            if query.lower() == "quit":
                break
            try:
                response = await self.process_query(query)
                print("\n" + response)
            except Exception as e:
                print(f"❌ Error: {e}")

    async def cleanup(self):
        await self.exit_stack.aclose()

async def main():
    if len(sys.argv) < 2:
        print("Usage: python client.py <path_to_server_script>")
        sys.exit(1)

    client = MCPClient()
    try:
        await client.connect_to_server(sys.argv[1])
        await client.chat_loop()
    finally:
        await client.cleanup()

if __name__ == "__main__":
    asyncio.run(main())
