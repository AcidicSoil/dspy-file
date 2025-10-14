# Prompt: Generate Prompt Execution Sequence

**Purpose:** Given a high-level goal and a set of available prompts, generate the logical execution sequence required to accomplish that goal by chaining the prompts together.

---

### **Inputs**

* **High-Level Goal:** $1
  * *A clear, one-sentence description of the final outcome the user wants to achieve.*
  * *Example: "Create and document a pull request for the currently staged changes."*

* **Available Prompts:**

    ```
    $2
    ```

  * *A list of candidate prompt names (e.g., from the output of `rank-root-prompts`).*
  * *Example: ['pr-desc.md', 'commit-msg.md', 'changed-files.md', 'review.md', 'release-notes.md']*

* **Context (Optional):** $3
  * *Any additional context, such as the current state of the git repository or specific files of interest.*
  * *Example: "The user has already staged files using `git add`."*

---

### **Instructions for the AI**

1. **Analyze the Goal:** Deconstruct the `$1` into a series of logical steps required to get from the starting state to the final outcome.

2. **Map Prompts to Steps:** For each logical step, identify the most suitable prompt from the `$2` list that can perform that step.
    * Consider the inputs and outputs of each prompt to determine dependencies. A prompt's input is often the output of a previous one.

3. **Establish Order:** Arrange the selected prompts into a numbered sequence based on their dependencies. The sequence should represent a complete and logical workflow.

4. **Identify Gaps:** If any necessary step in the workflow cannot be fulfilled by one of the available prompts, explicitly state what action or prompt is missing.

---

### **Required Output Format**

**Execution Sequence:**

1. **`[prompt_name_1.md]`**: [Brief justification for why this prompt is first and what it accomplishes.]
2. **`[prompt_name_2.md]`**: [Brief justification for why this prompt is second, and how it uses the output of the previous step.]
3. ...

**Identified Gaps (if any):**

* [Description of a missing step or prompt needed to complete the workflow.]

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "high_level_goal",
      "hint": "A clear, one-sentence description of the final outcome the user wants to achieve.",
      "example": "Create and document a pull request for the currently staged changes.",
      "required": true,
      "validate": ""
    },
    {
      "id": "$2",
      "name": "available_prompts",
      "hint": "A list of candidate prompt names (e.g., from the output of `rank-root-prompts`).",
      "example": "['pr-desc.md', 'commit-msg.md', 'changed-files.md', 'review.md', 'release-notes.md']",
      "required": true,
      "validate": ""
    },
    {
      "id": "$3",
      "name": "context",
      "hint": "Any additional context, such as the current state of the git repository or specific files of interest.",
      "example": "The user has already staged files using `git add`.",
      "required": false,
      "validate": ""
    }
  ]
}
