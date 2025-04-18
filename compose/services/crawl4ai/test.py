#!/usr/bin/env python3

import pprint
import requests
import time

api_token = "password"
headers = {"Authorization": f"Bearer {api_token}"} if api_token else {}


request = {
    "urls": "https://www.ipswichstar.co.uk/news/",
    "priority": 10,
     "extraction_config": {
        "type": "cosine",
        "params": {
            "semantic_filter": "local news",
            "word_count_threshold": 10,
            "max_dist": 0.2,
            "top_k": 3
        }
    }
}

DO_REQUEST = True

if DO_REQUEST:
    response = requests.post("http://localhost:11235/crawl", json=request, headers=headers)
    print(response.json())
    task_id = response.json()["task_id"]
    time.sleep(20)
else:
    task_id = "ad228fa4-3f06-4f28-aa7c-b2fa3123fad4"

# Get results
result = requests.get(f"http://localhost:11235/task/{task_id}", headers=headers)
extracted_content = result.json()["result"]["markdown"]
print(extracted_content)