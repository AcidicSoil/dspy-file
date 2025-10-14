Given the blame summary below, identify ownership hotspots and potential reviewers.

Blame authors (top contributors first):
!{git blame -w --line-porcelain $1 | sed -n 's/^author //p' | sort | uniq -c | sort -nr | sed -n '1,25p'}
