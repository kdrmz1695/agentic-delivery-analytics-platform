import streamlit as st
import plotly.express as px

from agents.sql_agent import generate_sql
from agents.explanation_agent import generate_explanation
from tools.bigquery_tool import run_bigquery_sql
from rag.search_helper import search_knowledge_base


st.set_page_config(
    page_title="Agentic Delivery Analytics Platform",
    layout="wide"
)

st.title("Agentic Delivery Analytics Platform")

st.markdown(
    "Ask business questions about delivery operations using AI-powered analytics."
)


example_questions = [
    "Which vehicle has the highest average delivery time?",
    "What is the delay rate by vehicle?",
    "Which traffic condition has the highest average delivery time?",
    "What is the average delivery speed by weather condition?",
    "Which order hour has the highest number of deliveries?",
    "What is the fastest delivery vehicle?"
]


selected_example = st.selectbox(
    "Example Questions",
    [""] + example_questions
)

question = st.text_input(
    "Enter your question:",
    value=selected_example
)


def show_auto_visualization(result):
    if result is None or len(result) == 0:
        st.info("No data available for visualization.")
        return

    numeric_columns = result.select_dtypes(include=["number"]).columns.tolist()
    categorical_columns = result.select_dtypes(exclude=["number"]).columns.tolist()

    if len(numeric_columns) < 1:
        st.info("No numeric metric found for visualization.")
        return

    st.subheader("Visualization")

    hour_columns = [
        col for col in result.columns
        if "hour" in col.lower()
    ]

    # CASE 1 — Hour analysis: line chart
    if hour_columns:
        x_col = hour_columns[0]
        y_candidates = [col for col in numeric_columns if col != x_col]
        y_col = y_candidates[0] if y_candidates else numeric_columns[0]

        chart_data = result.sort_values(by=x_col)

        fig = px.line(
            chart_data,
            x=x_col,
            y=y_col,
            markers=True,
            title=f"{y_col.replace('_', ' ').title()} by {x_col.replace('_', ' ').title()}"
        )

        fig.update_traces(
            line=dict(width=3),
            marker=dict(size=8)
        )

    # CASE 2 — Category chart: horizontal bar
    elif len(categorical_columns) >= 1:
        category_col = categorical_columns[0]

        metric_candidates = [
            col for col in numeric_columns
            if "count" not in col.lower()
        ]

        metric_col = metric_candidates[0] if metric_candidates else numeric_columns[0]

        chart_data = result.sort_values(by=metric_col, ascending=True)

        fig = px.bar(
            chart_data,
            x=metric_col,
            y=category_col,
            orientation="h",
            text=metric_col,
            color=category_col,
            title=f"{metric_col.replace('_', ' ').title()} by {category_col.replace('_', ' ').title()}",
            color_discrete_sequence=px.colors.qualitative.Set2
        )

        fig.update_traces(
            texttemplate="%{text:.2f}",
            textposition="outside",
            cliponaxis=False
        )

    # CASE 3 — Fallback
    else:
        metric_col = numeric_columns[0]

        chart_data = result.reset_index()

        fig = px.bar(
            chart_data,
            x="index",
            y=metric_col,
            text=metric_col,
            title=metric_col.replace("_", " ").title()
        )

        fig.update_traces(
            texttemplate="%{text:.2f}",
            textposition="outside"
        )

    fig.update_layout(
        height=360,
        margin=dict(l=40, r=80, t=60, b=40),
        template="plotly_white",
        title=dict(
            font=dict(size=18),
            x=0.02
        ),
        xaxis_title=None,
        yaxis_title=None,
        showlegend=False,
        bargap=0.45
    )

    st.plotly_chart(fig, use_container_width=True)


if st.button("Run Analysis"):

    if question.strip():

        with st.spinner("Generating SQL..."):
            sql = generate_sql(question)

        with st.spinner("Running BigQuery query..."):
            result = run_bigquery_sql(sql)

        with st.spinner("Retrieving knowledge base context..."):
            rag_results = search_knowledge_base(question)

            rag_context = "\n\n".join(
                [
                    f"Title: {doc['title']}\n"
                    f"Category: {doc['category']}\n"
                    f"Content: {doc['content']}"
                    for doc in rag_results
                ]
            )

        with st.spinner("Generating AI explanation..."):
            explanation = generate_explanation(
                user_question=question,
                query_result=result.to_string(),
                rag_context=rag_context
            )

        st.subheader("AI Explanation")
        st.write(explanation)

        st.subheader("Query Result")
        st.dataframe(result, use_container_width=True)

        show_auto_visualization(result)

        with st.expander("Generated SQL"):
            st.code(sql, language="sql")

        with st.expander("Retrieved RAG Documents"):
            for doc in rag_results:
                st.markdown(f"### {doc['title']}")
                st.write(f"Category: {doc['category']}")
                st.write(doc["content"])

    else:
        st.warning("Please enter a question.")