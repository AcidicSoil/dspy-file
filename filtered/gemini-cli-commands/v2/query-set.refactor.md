### Goal
$1

### Query Set
- $2
- $3
- $4
- $5
- $6
```

Examples:
- Input: `/query-set $2 $3`
- Output: Goal + queries with operators.

Notes:
- No evidence logging here. Use /research-item to execute.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "goal",
      "hint": "The goal of the query set",
      "example": "Find all users with admin privileges",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$2",
      "name": "query_element_1",
      "hint": "First query element in the set",
      "example": "user_id",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$3",
      "name": "query_element_2",
      "hint": "Second query element in the set",
      "example": "role",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$4",
      "name": "query_element_3",
      "hint": "Third query element in the set",
      "example": "status",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$5",
      "name": "query_element_4",
      "hint": "Fourth query element in the set",
      "example": "created_at",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$6",
      "name": "query_element_5",
      "hint": "Fifth query element in the set",
      "example": "updated_at",
      "required": true,
      "validate": ".*"
    }
  ]
}
