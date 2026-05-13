import json
from pathlib import Path
from sqlitesearch import TextSearchIndex

BASE_DIR = Path(__file__).resolve().parent.parent
KNOWLEDGE_BASE_PATH = BASE_DIR / "knowledge_base"
DB_PATH = BASE_DIR / "rag" / "knowledge_base.db"

def load_knowledge_documents():
    documents = []

    for file_path in KNOWLEDGE_BASE_PATH.glob("*.json"):
        with open(file_path, "r", encoding="utf-8") as file:
            data = json.load(file)
            documents.extend(data)

    return documents
def create_sqlite_index(documents):
    index = TextSearchIndex(
        text_fields=["title", "content"],
        keyword_fields=["category"],
        db_path=str(DB_PATH)
    )

    for document in documents:
        index.add(document)

    index.close()

if __name__ == "__main__":
    documents = load_knowledge_documents()
    create_sqlite_index(documents)

    print(f"Indexed {len(documents)} documents")
    print(f"SQLite knowledge base saved to: {DB_PATH}")