#!/usr/bin/env bash
# Podcast Transcript Dataset - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~podcast-transcript-dataset"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. One feed, latest episodes
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "rssUrls": [
        "https://podnews.net/rss"
      ],
      "maxEpisodesPerFeed": 10
    }'

# 2. Several feeds, only this year, long transcripts only
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "rssUrls": [
        "https://podnews.net/rss",
        "https://mp3s.nashownotes.com/pc20rss.xml"
      ],
      "maxEpisodesPerFeed": 50,
      "publishedAfter": "2026-01-01",
      "minWordCount": 500
    }'

# 3. Synchronous run - get items in the same response (small jobs only)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}&format=json" \
  -H "Content-Type: application/json" \
  -d '{
      "rssUrls": [
        "https://podnews.net/rss"
      ],
      "maxEpisodesPerFeed": 2
    }'
