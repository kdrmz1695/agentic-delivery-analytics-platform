from agents.sql_agent import generate_sql
from agents.explanation_agent import generate_explanation

from tools.bigquery_tool import run_bigquery_sql

from rag.search_helper import search_knowledge_base


question = "Which vehicle has the highest average delivery time?"


# STEP 1 — Generate SQL
sql = generate_sql(question)

print("\nGenerated SQL:")
print(sql)


# STEP 2 — Execute BigQuery query
result = run_bigquery_sql(sql)

print("\nQuery Result:")
print(result)


# STEP 3 — Retrieve relevant RAG context
rag_results = search_knowledge_base(question)

rag_context = "\n\n".join(
    [
        f"Title: {doc['title']}\nCategory: {doc['category']}\nContent: {doc['content']}"
        for doc in rag_results
    ]
)

print("\nRAG Context:")
print(rag_context)


# STEP 4 — Generate explanation
explanation = generate_explanation(
    user_question=question,
    query_result=result.to_string(),
    rag_context=rag_context
)

print("\nAI Explanation:")
print(explanation)