<!-- $1=blame command output (author list with counts), $2=file path being analyzed -->
**Authorship Hotspot Analysis**

Given the blame summary below, identify ownership hotspots and suggest potential reviewers for code maintenance or onboarding.

Blame authors (top contributors first):
$1

Output format:
- List top 5 contributing authors by line count.
- Define "ownership hotspot" as a contributor with >10% of total lines authored in a file.
- Suggest 1–2 reviewers based on diversity of contribution (e.g., different team members or branches).
- Flag any author with more than 30% ownership as requiring special attention.

Optional:
- If the file has been modified by only one contributor, note this as "centralized ownership" and recommend review by a peer.
- Consider if the hotspots align with team roles (e.g., backend vs. frontend).

Affected files: $2

Open questions:
- How should we define "hotspot" in context of code size or complexity?
- Should reviewers be selected based on contribution history or team structure?
