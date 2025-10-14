description = "Generate unit tests for a given source file."
prompt = """
Given the file content, generate focused unit tests with clear arrange/act/assert and edge cases.


Framework hints (package.json):
@{$1}


Source (first 400 lines):
!{sed -n '1,400p' {$2}}
"""
