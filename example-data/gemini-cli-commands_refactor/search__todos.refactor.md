description = "Find and group TODO/FIXME annotations."
prompt = """
!{rg -n "$1" -g '!node_modules' . || grep -RInE "$1" .}
"""
