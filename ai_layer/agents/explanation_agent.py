from openai import OpenAI


client = OpenAI()

def generate_explanation(user_question:str, query_result:str) -> str:
    prompt = f"""
    You are a senior delivery analytics expert.
    A user asked the following question:
    {user_question}
    The SQL query returned this result:
    {query_result}
    Your Tasks are :
    - Explain the result clearly in plain English.
    - Keep the explanation concise.
    - Mention important insights or patterns if visible.
    - Do not mention SQL.
    """
    response = client.responses.create(
        model = "gpt-5.2",
        input = prompt
    )
    return response.output_text.strip()