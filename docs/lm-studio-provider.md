# LM Studio Provider Integration Notes

- Start the local API server from LM Studio's Developer tab or via `lms server start` (CLI installed with `npx lmstudio install-cli`) to expose local models over HTTP.
- Run `dspyteach` with `--provider lmstudio --model <model-id> --api-base http://localhost:1234/v1` (or set the `DSPYTEACH_PROVIDER`, `DSPYTEACH_MODEL`, and `DSPYTEACH_API_BASE` environment variables) so the CLI targets LM Studio's OpenAI-compatible endpoint.
- OpenAI SDKs can target LM Studio by switching their base URL to `http://localhost:1234/v1`. Endpoints `/v1/models`, `/v1/responses`, `/v1/chat/completions`, `/v1/completions`, and `/v1/embeddings` are supported, mirroring OpenAI behaviour.
- The Python OpenAI client works out of the box with `base_url="http://localhost:1234/v1"` and any placeholder API key (e.g. `"lm-studio"`), enabling structured-output workflows identical to OpenAI.
- A richer beta REST surface is available at `/api/v0/*`, returning chat/completions/embeddings plus model metadata (TTFT, tokens/sec, runtime, quantization). It is enabled by the same server command.
- Operational flags: choose a custom port with `lms server start --port <port>`, allow browser access with `--cors`, and point CLI utilities to remote hosts using `--host` for commands such as `lms ls`, `lms ps`, `lms load`, and `lms unload`.
