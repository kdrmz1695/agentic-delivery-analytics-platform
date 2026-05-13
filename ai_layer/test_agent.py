from agents.sql_agent import generate_sql
from tools.bigquery_tool import run_bigquery_sql
from rag.search_helper import search_knowledge_base
from agents.explanation_agent import generate_explanation


test_questions = [
    "Which vehicle has the highest average delivery time?",
    "What is the delay rate by vehicle?",
    "Which traffic condition has the highest average delivery time?",
    "What is the average delivery speed by weather condition?",
    "Which order hour has the highest number of deliveries?"
]


for question in test_questions:
    print("\n" + "=" * 80)
    print("Question:")
    print(question)

    sql = generate_sql(question)

    print("\nGenerated SQL:")
    print(sql)

    result = run_bigquery_sql(sql)

    print("\nQuery Result:")
    print(result)

    rag_results = search_knowledge_base(question)

    rag_context = "\n\n".join(
        [
            f"Title: {doc['title']}\nCategory: {doc['category']}\nContent: {doc['content']}"
            for doc in rag_results
        ]
    )
    print("\nRAG Retrieved Documents:")
    for i, doc in enumerate(rag_results, start=1):
        print(f"{i}. Title: {doc['title']}")
        print(f"   Category: {doc['category']}")
        print(f"   Content preview: {doc['content'][:200]}...")
    explanation = generate_explanation(
        user_question=question,
        query_result=result.to_string(),
        rag_context=rag_context
    )

    print("\nAI Explanation:")
    print(explanation)