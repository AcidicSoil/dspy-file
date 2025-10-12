description = "Suggest a plan to raise coverage based on uncovered areas."
prompt = """
Using coverage artifacts (if available) and repository map, propose the highest‑ROI tests to add.


Coverage hints:
!{find $1 -name 'coverage*' -type f -maxdepth 3 -print -exec head -n 40 {} \\; 2>/dev/null}


Repo map:
!{git ls-files | sed -n '1,400p'}
"""
