"""Podcast Transcript Dataset - Python example.

Install:
    pip install apify-client

Run:
    APIFY_TOKEN=your_token python python.py
"""

import os
from apify_client import ApifyClient

TOKEN = os.environ.get("APIFY_TOKEN", "YOUR_TOKEN")
ACTOR = "Turboextract/podcast-transcript-dataset"

client = ApifyClient(TOKEN)

# 1. Start the actor and wait for it to finish
run_input = {
    "rssUrls": ["https://podnews.net/rss"],
    "maxEpisodesPerFeed": 100,
    "minWordCount": 200,
}

run = client.actor(ACTOR).call(run_input=run_input)

# 2. Stream results
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(f"[{item['wordCount']:>5}w] {item['episodeTitle']}")
    print(f"        {item['transcriptSource']}")

# 3. Or pull all at once into a list
items = list(client.dataset(run["defaultDatasetId"]).iterate_items())
print(f"\n{len(items)} episodes returned.")
