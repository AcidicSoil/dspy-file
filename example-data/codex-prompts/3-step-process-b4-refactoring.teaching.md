# Teaching Brief: Pre-Refactoring Process Documentation Framework

## Context & Purpose
This teaching brief is designed for instructors guiding learners through the critical *pre-refactoring* documentation phase of software improvement. The source file path `/home/user/.codex/prompts/temp-prompts/3-step-process-b4-refactoring.md` represents a template for instructors to systematically capture workflow context before initiating code changes. This framework helps learners avoid common pitfalls by emphasizing explicit documentation of current processes, dependencies, and validation points—essential for safe and effective refactoring.

## Key Teaching Focus Areas

### Overview
Instructors should guide learners to articulate a clear, concise summary of the *current state* of the system being refactored. This includes identifying the primary purpose of the code, its stakeholders, and the specific problem it solves—avoiding assumptions about future changes. For example: *"This module handles user authentication with JWT tokens, currently supporting 3 login methods but lacking rate-limiting for security."*

### Core Concepts
Learners must manually clarify foundational concepts through structured questioning:  
- What is the *single responsibility* of this component?  
- How do dependencies (e.g., external APIs, databases) impact its behavior?  
- What edge cases are currently handled (and which are unaddressed)?  
*Example:* "The token validation function checks expiration time but does not handle token forgery—this must be documented before refactoring."

### Practical Workflows
Instructors should teach learners to follow this 3-step documentation process:  
1. **Map the current workflow**: Identify all inputs, transformations, and outputs.  
2. **Document decision points**: Note where logic branches (e.g., "If user is admin → skip rate limit").  
3. **Validate assumptions**: Explicitly state what *isn’t* documented (e.g., "No error handling for expired tokens").  

### Critical Pitfalls to Avoid
- **Assuming automation**: Never skip manual verification of edge cases (e.g., "What happens if the database is down during token validation?").  
- **Overlooking dependencies**: Failing to document external services (e.g., OAuth providers) can cause integration failures post-refactoring.  
- **Ignoring test coverage**: Critical paths must be testable *before* code changes—this prevents regression in production.  

### Integration & Testing Focus
- **Integration touchpoints**: Highlight where new code will interact with existing systems (e.g., "Refactored auth module must sync with user service via REST API").  
- **Testing priorities**: Focus unit tests on:  
  (a) Boundary conditions (e.g., token expiration edge cases),  
  (b) Error propagation paths,  
  (c) Dependency failures (e.g., network timeouts).  

### Real-World Usage Patterns
This framework works best when learners:  
- Apply it to *existing* codebases (not hypothetical scenarios),  
- Use it before any refactoring begins,  
- Share documentation with stakeholders to align expectations.  
*Example:* A team refactoring payment processing first documented all transaction states and failure modes before changing the payment gateway logic.

### Recommended References
- *Refactoring: Improving the Design of Existing Code* by Martin Fowler (chapters on documentation)  
- *Clean Code* by Robert C. Martin (sections on "simple" vs. "complex" code)  

## Why This Matters
By embedding this pre-refactoring documentation step, learners develop habits that prevent costly technical debt. Instructors who teach this process help students transition from "quick fixes" to *sustainable* improvements—directly addressing the most common refactoring failures observed in production environments.
