---
name: brave
description: Web search and content extraction via Brave Search API. Use for searching documentation, facts, or any web content. Lightweight, no browser required.
---

# Brave

Use this skill when you need lightweight web search or page-content extraction without opening a browser.

## When to Use

- Searching for documentation or API references.
- Looking up facts or current information.
- Fetching content from a specific URL.
- Gathering a small set of relevant web results for follow-up reading.

## Search

```bash
brave search "query"
brave search "query" -n 10
brave search "query" --freshness pw
brave search "query" --freshness 2024-01-01to2024-06-30
brave search "query" --country DE
```

### Search options

- `-n <num>`: Number of results. Default `5`, max `20`.
- `--country <code>`: Two-letter country code. Default `US`.
- `--freshness <period>`: Time filter.
  - `pd`: Past day.
  - `pw`: Past week.
  - `pm`: Past month.
  - `py`: Past year.
  - `YYYY-MM-DDtoYYYY-MM-DD`: Custom date range.

## Fetch page content

```bash
brave fetch https://example.com/article
```

Use this to pull readable markdown from a specific page when you already have the URL.

## Guidance

- Prefer a narrow query over a broad one.
- Search first, then fetch only promising URLs.
- Start with a small result count, then widen only if needed.
- Summarize findings after searching instead of dumping raw results unless the user asked for verbatim output.
