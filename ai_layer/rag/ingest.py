import json
from pathlib import Path
from minsearch import Index
from pprint import pprint
KNOWLEDGE_BASE_PATH = Path("../knowledge_base")

documents = []

for file_path in KNOWLEDGE_BASE_PATH.glob("*.json"):
    with open(file_path, "r", encoding="utf-8") as file:
        data = json.load(file)
        documents.extend(data)


index = Index(
    text_fields=["title","content"],
    keyword_fields=["category"]
)
index.fit(documents)

test=index.search(
    query="delay rate",
    num_results=3
)
pprint(test)