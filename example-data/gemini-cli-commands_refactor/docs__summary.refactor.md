description = "Produce a README‑level summary of the repo."
prompt = """
Generate a high‑level summary (What, Why, How, Getting Started).


Repo map (first 400 files):
!{git ls-files | sed -n '1,400p'}


Key docs if present:
@{$1}
@{$1}
"""
