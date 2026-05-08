from agents.sql_agent import generate_sql
from tools.bigquery_tool import run_bigquery_sql

question = "Which vehicle has the highest average delivery time?"

sql = generate_sql(question)

print("Generated SQL:")
print(sql)

result = run_bigquery_sql(sql)

print("\nQuery Result:")
print(result)