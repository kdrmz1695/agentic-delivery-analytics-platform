from openai import OpenAI

client = OpenAI()


def generate_explanation(
    user_question: str,
    query_result: str,
    rag_context: str
) -> str:
    prompt = f"""
You are a senior delivery analytics expert.

A user asked the following question:
{user_question}

Relevant business context:
{rag_context}

The SQL query returned this result:
{query_result}

Your task:
- Explain the result clearly in plain English.
- Use the relevant business context when helpful.
- Keep the explanation concise.
- Mention important insights or patterns if visible.
- Do not mention SQL.
- Do not use markdown formatting such as bold text, bullet points, or headings.
"""

    response = client.responses.create(
        model="gpt-5.2",
        input=prompt
    )

    return response.output_text.strip()