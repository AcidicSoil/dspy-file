# Feature Flags

## Metadata

- **Identifier**: feature-flags  
- **Categories**: Implementation, Configuration, Security  
- **Stage**: Implementation  
- **Dependencies**: []  
- **Provided Artifacts**: SDK snippet, example usage, guardrail checklist  
- **Summary**: Do integrate feature flags to achieve secure, typed flag management with enforcement and monitoring.

---

**Steps:**

1. Select provider (LaunchDarkly, Unleash, Flagsmith, custom).
2. Add SDK init in web/api with bootstrap values and offline mode for dev.
3. Define flag naming and ownership. Add kill‑switch pattern and monitoring.

**Output format:** SDK snippet, example usage, and guardrail checklist.

**Examples:** `/feature-flags launchdarkly`.

**Notes:** Ensure flags are typed and expire with tickets.
