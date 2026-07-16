# Knowledge Base API

Search and fetch UXON Help Center articles from an AI agent. Use these commands when a user asks product or setup questions and the answer should be grounded in UXON documentation.

## Core Commands

- `docs.list`: list available Help Center articles.
- `docs.search`: search Help Center articles by phrase.
- `docs.get`: fetch one article by ID.

## Search Articles

```json
{
  "command": "docs.search",
  "input": {
    "query": "connect Claude to UXON",
    "perPage": 5,
    "state": "published"
  }
}
```

## Fetch An Article

```json
{
  "command": "docs.get",
  "input": {
    "articleId": "article_id"
  }
}
```

## Agent Answering Protocol

1. Run `docs.search` with the user's question.
2. Choose the best matching article.
3. Run `docs.get`.
4. Answer using article facts.
5. Include the article URL when available.

## Related Files

- [FAQ](../docs/faq.md)
- [Agent command playbook](../SKILLS.md)
