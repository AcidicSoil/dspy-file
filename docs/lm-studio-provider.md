# LM Studio Provider Integration Notes

- Start the local API server from LM Studio's Developer tab or via `lms server start` (CLI installed with `npx lmstudio install-cli`) to expose local models over HTTP.
- On Windows + WSL, enable *Serve on local network* under the Developer tab so the API binds to `0.0.0.0`; then call it from WSL using the Windows host IP (for example `http://<host-ip>:1234/v1`).
- Run `dspyteach` with `--provider lmstudio --model <model-id> --api-base http://localhost:1234/v1` (or set the `DSPYTEACH_PROVIDER`, `DSPYTEACH_MODEL`, and `DSPYTEACH_API_BASE` environment variables) so the CLI targets LM Studio's OpenAI-compatible endpoint.
- OpenAI SDKs can target LM Studio by switching their base URL to `http://localhost:1234/v1`. Endpoints `/v1/models`, `/v1/responses`, `/v1/chat/completions`, `/v1/completions`, and `/v1/embeddings` are supported, mirroring OpenAI behaviour.
- The Python OpenAI client works out of the box with `base_url="http://localhost:1234/v1"` and any placeholder API key (e.g. `"lm-studio"`), enabling structured-output workflows identical to OpenAI.
- A richer beta REST surface is available at `/api/v0/*`, returning chat/completions/embeddings plus model metadata (TTFT, tokens/sec, runtime, quantization). It is enabled by the same server command.
- Operational flags: choose a custom port with `lms server start --port <port>`, allow browser access with `--cors`, and point CLI utilities to remote hosts using `--host` for commands such as `lms ls`, `lms ps`, `lms load`, and `lms unload`.

---

**WSL note:** When LM Studio runs on Windows but `dspyteach` runs from WSL, toggle *Serve on local network* in LM Studio's Developer settings so the API binds to `0.0.0.0`. Then point `--api-base` at the Windows host IP (for example `http://<host-ip>:1234/v1`) instead of `localhost`.

---

## Setup .env

```bash
cp .env.example .env
```

### debugging calls for troubleshooting

#### Live view + write BOTH stdout/stderr into one file

##### Change the address to the address shown in the developer tab in LM-Studio after toggling "Serve on Local Network"

```bash
{ yes "" | dspyteach ~/.codex/prompts/temp-prompts \
    --provider lmstudio --model qwen/qwen3-4b-thinking-2507 \
    --api-base http://192.168.0.1:1234/v1 --confirm-each; } \
  |& tee "dspyteach.all.$(date +%Y%m%d-%H%M%S).log"
```

#### Add an alias for dspyteach in your ~/.bashrc or $PROFILE for easier usage

```bash
{ yes "" | dt -m refactor ~/.gemini/commands \
    --provider lmstudio \
    --api-base http://localhost:1234/v1 --confirm-each; } \
  |& tee "dspyteach.all.$(date +%Y%m%d-%H%M%S).log"

```

---

### **NOTE**

- Using the local-ip only when user is utilizing dspyteach in a WSL environment attempting to make a call to LM-Studio served on Windows host.
- Other than that, just use the default port

```bash
curl http://<local-ip>/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen/qwen3-4b-thinking-2507",
    "messages": [
      { "role": "system", "content": "Always answer in rhymes. Today is Thursday" },
      { "role": "user", "content": "What day is it today?" }
    ],
    "temperature": 0.7,
    "max_tokens": -1,
    "stream": false
}'

```
