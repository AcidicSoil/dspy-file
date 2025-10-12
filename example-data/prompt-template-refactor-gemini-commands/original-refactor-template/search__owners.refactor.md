**Search Owner Suggestion Prompt**

This prompt is designed to suggest likely owners or reviewers for a given code path based on CODEOWNERS configuration and recent commit history.

- **Purpose**: Identify potential owners/reviewers by analyzing both configured ownership rules and historical contribution patterns.
- **Input Sources**:
  - `CODEOWNERS` file (if present) — defines explicit ownership rules.
  - Git commit logs — identifies recent authors of the code path.

The prompt dynamically evaluates these sources to generate a reasoned suggestion list.

**Output Format**
- A structured response containing:
  - Reasoning behind owner suggestions
  - List of suggested owners or reviewers, with justification

---

$1  
$2  
$3
