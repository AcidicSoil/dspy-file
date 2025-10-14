```md
# TODO/FIXME Annotation Summary

## Goal
Find and group TODO/FIXME annotations.

## Evidence
- Command used: `rg -n "TODO|FIXME" -g '!node_modules' . || grep -RInE 'TODO|FIXME' .`
- Files scanned: All project files excluding `node_modules`

## Grouped Annotations

### [1] Group Name
- Description: [Brief description of the group]
- Count: [Number of annotations in this group]
- Owner: [Assignee or owner if specified]
- Example: [Sample TODO/FIXME line]

### [2] Group Name
- Description: [Brief description of the group]
- Count: [Number of annotations in this group]
- Owner: [Assignee or owner if specified]
- Example: [Sample TODO/FIXME line]

## Priorities and Next Steps

1. [Priority level] - [Description of next step]
2. [Priority level] - [Description of next step]
3. [Priority level] - [Description of next step]

## Notes
[Additional notes or context]
```
