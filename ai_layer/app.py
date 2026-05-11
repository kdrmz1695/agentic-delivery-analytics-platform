from agents.sql_agent import generate_sql
from tools.bigquery_tool import run_bigquery_sql
from agents.explanation_agent import generate_explanation

question = "Which vehicle has the highest average delivery time?"

sql = generate_sql(question)

print("Generated SQL:")
print(sql)

result = run_bigquery_sql(sql)

print("\nQuery Result:")
print(result)

explanation = generate_explanation(
    user_question=question,
    query_result = result.to_string()
)
print("\nAI Explanation:")
print(explanation)