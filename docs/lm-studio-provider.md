---
title: "LM Studio Provider Integration"
description: "Configure dspyteach to use LM Studio's OpenAI-compatible API and verify the connection across macOS, Windows, and WSL."
---

# LM Studio Provider Integration Notes

<Steps>
<Step title="Start the LM Studio API server">
Run the server from the Developer tab or with the CLI (`npx lmstudio install-cli && lms server start`). This exposes the OpenAI-compatible endpoints on `http://localhost:1234/v1`.

<Check>LM Studio shows the model as `Loaded` and the server status indicator is green.</Check>
</Step>

<Step title="Configure dspyteach to target LM Studio">
Use CLI flags or environment variables to point the analyzer at the LM Studio endpoint.

```bash
dspyteach ./notes \
  --provider lmstudio \
  --model qwen3-4b-instruct-2507@q6_k_xl \
  --api-base http://localhost:1234/v1
```

Alternatively, copy `.env.example` to `.env` and set `DSPYTEACH_PROVIDER`, `DSPYTEACH_MODEL`, and `DSPYTEACH_API_BASE`.

<Tip>OpenAI SDKs work unchanged when you pass `base_url="http://localhost:1234/v1"` and a placeholder key such as `"lm-studio"`.</Tip>
</Step>

<Step title="Verify the connection">
Confirm the API responds before running a long batch.

```bash
curl http://localhost:1234/v1/models
```

<Check>The response lists the models you have loaded in LM Studio.</Check>
</Step>
</Steps>

## Troubleshooting and advanced usage

<Warning>
When LM Studio runs on Windows but you execute `dspyteach` inside WSL, enable **Serve on local network** so the server binds to `0.0.0.0`, then target the Windows host IP (e.g., `http://192.168.0.10:1234/v1`).
</Warning>

- The CLI accepts additional flags such as `--cors`, `--port`, and `--host` via `lms server start` to expose the API on different interfaces.
- REST endpoints `/v1/models`, `/v1/chat/completions`, `/v1/completions`, `/v1/responses`, and `/v1/embeddings` mirror OpenAI behavior. A beta surface at `/api/v0/*` adds model metadata (TTFT, tokens/sec, quantization).
- For the Python OpenAI client, set `from openai import OpenAI; client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")` to reuse existing structured-output code.

### Capture verbose logs during debugging

```bash
{ yes "" | dspyteach ./prompts \
    --provider lmstudio \
    --model qwen3-4b-thinking-2507 \
    --api-base http://localhost:1234/v1 \
    --confirm-each; } |& tee "dspyteach.$(date +%Y%m%d-%H%M%S).log"
```

<Tip>Expect the log file to contain both the CLI progress output and any HTTP errors from LM Studio for later review.</Tip>

### Spot-check the chat completion endpoint

```bash
curl http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3-4b-thinking-2507",
    "messages": [
      { "role": "system", "content": "Always answer in rhymes." },
      { "role": "user", "content": "Name one benefit of dspyteach." }
    ]
  }'
```

<Check>A JSON response containing a rhymed assistant message confirms the endpoint is healthy.</Check>
