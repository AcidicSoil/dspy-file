```md
# Auth Scaffold

## Metadata

- **Identifier**: auth-scaffold-provider
- **Categories**: Scaffold, Auth, Security
- **Stage**: initialization
- **Dependencies**: []
- **Provided Artifacts**: route list, config keys, mitigations table
- **Summary**: Scaffold auth flows to achieve secure session management with threat modeling.

---

# Auth Scaffold

Trigger: /auth-scaffold <[[ ## 1 ## ]]>

Purpose: Scaffold auth flows, routes, storage, and a basic threat model.

**Steps:**

1. Select provider ([[ ## 2 ## ]]) and persistence for sessions.
2. Generate routes: login, callback, logout, session refresh.
3. Add CSRF, state, PKCE where applicable. Include secure cookie flags.
4. Document threat model: replay, fixation, token leakage, SSRF on callbacks.
5. Wire to frontend with protected routes and user context.

**Output format:** route list, config keys, and mitigations table.

**Examples:** `/auth-scaffold [[ ## 3 ## ]]` → NextAuth/Passport/Custom adapter plan.

**Notes:** Never print real secrets. Use placeholders in `.env.example`.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
