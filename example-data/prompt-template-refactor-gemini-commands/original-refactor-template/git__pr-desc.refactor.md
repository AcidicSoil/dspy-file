<!-- $1=base branch (e.g., origin/main), $2=user context (e.g., ticket ID or brief note), $3=list of changed files with status, $4=high-level diff stats (added/modified/deleted) -->
**PR Description Generator**

Generate a concise and structured pull request description using the following format:

1. **Summary**
   - Briefly summarize what this PR achieves in one sentence.

2. **Context**
   - Why is this change needed? Link to user stories, tickets, or requirements (e.g., "Addresses issue #123").

3. **Changes**
   - List the files modified and describe key changes.
   - Format: `File path (status)` — e.g., `src/utils.ts (modified)`

4. **Screenshots (if applicable)**
   - Include a link or embedded image showing visual impact.

5. **Risk**
   - What are potential risks? Any breaking changes, performance issues, or data loss?

6. **Test Plan**
   - How will this change be verified? Unit tests, integration tests, or manual checks?

7. **Rollback**
   - If a rollback is needed, describe how to revert the change.

8. **Release Notes (if user-facing)**
   - Draft what users would see in release notes — keep it simple and benefit-focused.

---

**Output format**:  
Structured markdown with clear section headers and bullet points. Avoid technical jargon unless necessary for clarity.

---

*Note: Replace placeholders below with actual data from the environment:*  
- $1 = base branch (e.g., origin/main)  
- $2 = user context (e.g., "Fixes ticket #456", or "Improves login flow")  
- $3 = list of changed files (name + status) — generated via `git diff --name-status origin/main...HEAD`  
- $4 = high-level stats — generated via `git diff --shortstat origin/main...HEAD`
