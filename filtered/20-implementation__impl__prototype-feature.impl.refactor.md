```md
# Prototype Feature

Trigger: /prototype-feature

Purpose: Spin up a standalone prototype in a clean repo before merging into main.

## Steps

1. Create a scratch directory name suggestion and scaffolding commands.
2. Generate minimal app with only the feature and hardcoded data.
3. Add E2E test covering the prototype flow.
4. When validated, list the minimal patches to port back.

## Output format

- Scaffold plan and migration notes.

## Template Placeholders

1. {{scratch_directory_name}} - Name of the scratch directory for the prototype.
2. {{feature_description}} - Description of the feature being prototyped.
3. {{hardcoded_data}} - Hardcoded data used in the minimal app.
4. {{e2e_test_coverage}} - Description of E2E test coverage for the prototype flow.
5. {{migration_notes}} - Notes on minimal patches to port back to main.

## Example Usage

1. {{scratch_directory_name}}: feature-prototype-{{feature_description}}
2. {{feature_description}}: User authentication
3. {{hardcoded_data}}: Sample user data for testing
4. {{e2e_test_coverage}}: Tests for login and logout flows
5. {{migration_notes}}: Changes to be applied to main branch after validation

## Template Structure

1. Directory Setup
   - {{scratch_directory_name}}

2. Feature Implementation
   - {{feature_description}}
   - {{hardcoded_data}}

3. Testing
   - {{e2e_test_coverage}}

4. Migration
   - {{migration_notes}}
```
