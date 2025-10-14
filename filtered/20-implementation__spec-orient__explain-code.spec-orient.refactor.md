```md
# Explain Code

Trigger: /explain-code

Purpose: Provide line-by-line explanations for a given file or diff.

## Steps

1. Accept a file path or apply to staged diff.
2. Explain blocks with comments on purpose, inputs, outputs, and caveats.
3. Highlight risky assumptions and complexity hot spots.

## Output format

- Annotated markdown with code fences and callouts.

### Template Placeholder Sections

1. [[ ## file_path ## ]]
   {file_path}

2. [[ ## file_content ## ]]
   {file_content}

3. [[ ## reasoning ## ]]
   {reasoning}

4. [[ ## template_markdown ## ]]
   {template_markdown}

5. [[ ## completed ## ]]
   In adhering to this structure, your objective is: 
   # Command: /markdown:wrap-md-fence
   
   # Usage: /markdown:wrap-md-fence "your content here"
   
   # Args
   
   # - {{content}}: raw bytes to wrap verbatim inside the fence
   
   prompt = """
   Wrap the provided {{content}} verbatim with a Markdown code fence labeled md.
   
   Rules:
   
   * Zero changes to {{content}} (byte-for-byte).
   * Preserve encoding, line endings, and terminal newline presence/absence.
   * No additional output or whitespace outside the fence.
   
   Output exactly:
   
   ```md
   {{content}}
   ```
   
   Acceptance:
   
   * Inner bytes are identical to {{content}}.
   * Only the opening line `md and the closing` are added.
     """
```
