<!-- $1=description, $2=prompt, $3=framework_hints, $4=source_content, $5=args -->
**Unit Test Generation Prompt**

Generate focused unit tests for a given source file with clear arrange/act/assert structure and edge cases.

Framework hints (package.json):
$3

Source (first 400 lines):
$4

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[$2]]`, and then ending with the marker for `[[$5]]`.
