<!-- $1 = goal sentence (1 sentence) -->
<!-- $2 = query 1 (with operators) -->
<!-- $3 = query 2 (with operators) -->
<!-- $4 = query 3 (with operators) -->
<!-- $5 = query 4 (with operators) -->
<!-- $6 = query 5 (with operators) -->
<!-- $7 = query 6 (with operators) -->

**Query Generator**

Trigger: /query-set
Purpose: Generate 4–8 targeted web search queries with operators, entity variants, and recency filters for a given objective.

Steps:
1. Restate the goal with entities and time window.
2. Produce queries using operators: site:, filetype:, inurl:, quotes, OR, date filters.
3. Include synonyms and common misspellings.
4. Mix intents: define, compare, integrate, configure, limitations, pricing, API, case study.

Output format:
```
### Goal
$1

### Query Set
- $2
- $3
- $4
- $5
- $6
```

Notes:
- No evidence logging here. Use /research-item to execute.
