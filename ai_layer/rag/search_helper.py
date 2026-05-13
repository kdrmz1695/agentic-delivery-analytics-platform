from pathlib import Path
from sqlitesearch import TextSearchIndex
from pprint import pprint

BASE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = BASE_DIR / "rag" / "knowledge_base.db"

def search_knowledge_base(query: str, num_results: int = 2):

    index = TextSearchIndex(
        text_fields=["title", "content"],
        keyword_fields=["category"],
        db_path=str(DB_PATH)
    )

    results = index.search(
        query=query,
        num_results=num_results
    )

    return results

if __name__ == "__main__":


    results = search_knowledge_base("delay rate")

    pprint(results)