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
- For comparison, ranking, highest, lowest, best, worst, most, or least analytical questions, return the full grouped ranking unless the user explicitly asks for only one result.
- Do not use LIMIT 1 for comparison or ranking questions unless the user clearly says top 1, only one, single result, or first result.
- Use ORDER BY to make ranking results clear.

User question:
{user_question}
"""

    response = client.responses.create(
        model="gpt-5.2",
        input=prompt
    )

    return response.output_text.strip()