from openai import OpenAI
from config.schema_context import SCHEMA_CONTEXT

client = OpenAI()


def generate_sql(user_question: str) -> str:
    prompt = f"""
{SCHEMA_CONTEXT}

Task:
Convert the user's question into a valid BigQuery SQL query.

Rules:
- Return ONLY the SQL query.
- Do not explain.
- Do not use markdown.
- Use full table paths with backticks.
- Only use SELECT queries.

User question:
{user_question}
"""

    response = client.responses.create(
        model="gpt-5.2",
        input=prompt
    )

    return response.output_text.strip()