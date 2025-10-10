description = "Show how an internal API is used across the codebase."
prompt = """
Summarize common usage patterns and potential misuses for the symbol.


!{rg -n $1 . || grep -RIn $1 .}
"""
