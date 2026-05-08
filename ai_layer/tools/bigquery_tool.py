from google.cloud import bigquery

PROJECT_ID = "delivery-analytics-project"


def run_bigquery_sql(sql: str):
    client = bigquery.Client(project=PROJECT_ID)
    result = client.query(sql).to_dataframe()
    return result