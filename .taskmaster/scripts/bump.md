# bump version and commit workflow

uv build
uv version --bump patch --bump beta
git add .
git commit -m "Release: 0.1.4b1"
git tag -a v0.1.4b1 -m "Release 0.1.4b1"
git push origin HEAD --tags

{ yes "" | dt -m refactor ~/.gemini/commands \
    --provider lmstudio \
    --api-base <http://10.0.0.81:1234/v1> --confirm-each; } \
  |& tee "dspyteach.all.$(date +%Y%m%d-%H%M%S).log"

{ dt generate-sequence \
  --goal "Cut a release" ~/.codex/prompts \
    --provider lmstudio \
    --api-base http://10.0.0.81:1234/v1; }

dspyteach rank-prompts "How do I commit my changes?" ~/.codex/prompts 0.6

dt generate-sequence \
  --goal "Cut a release"


{ dspyteach generate-sequence "Cut a release" -P lmstudio -B 10.0.0.81:1234/v1 ;} |& tee "dspyteach.all.$(date +%Y%m%d-%H%M%S).log"


dspyteach -P lmstudio -B 10.0.0.81:1234/v1 generate-sequence "Cut a release"


 dspyteach generate-sequence "Cut a release"
  dspyteach -P lmstudio -B <http://localhost:1234/v1> generate-sequence
  --goal "Cut a release"
