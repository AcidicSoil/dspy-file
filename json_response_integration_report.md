# Integration Report: JSON Response Formatting

**Date:** October 17, 2025
**Status:** Proposed

## 1. Objective

This document outlines a proposal to integrate a feature into the `dspy-file` command-line tool (`analyze_file_cli.py`) to enforce structured JSON output from language models. This is based on the `response_format` parameter within the **DSPy framework**, which instructs DSPy to request JSON-formatted output from the underlying model provider.

## 2. DSPy Framework Abstraction

It is important to note that `response_format` is a feature of the `dspy.LM` abstraction layer, not necessarily a native parameter of the end-provider's API. The DSPy framework is responsible for translating this parameter into the correct, provider-specific API call.

- When `response_format` is passed to `dspy.LM` for an **Ollama** model, DSPy's Ollama client handler converts this into the native `format: 'json'` parameter in the request sent to the Ollama server.
- Similarly, for **OpenAI-compatible** endpoints, DSPy would use the provider's required format, such as `response_format={"type": "json_object"}`.

The code proposed in this document correctly interacts with the DSPy abstraction layer.

## 3. Initial Proposal (Ollama-Specific)

The initial goal was to create an optional, provider-specific feature for users of Ollama.

### 3.1. Key Mechanisms

1. **CLI Flag:** A new `--json-response` command-line flag was proposed to allow users to explicitly enable this functionality.
2. **Provider Gating:** The core logic is enclosed in `if provider is Provider.OLLAMA:` checks to ensure it only runs when Ollama is the selected provider.
3. **External Schemas:** The proposal involves loading the required JSON schema from external files (e.g., `teach.schema.json`, `refactor.schema.json`) based on the selected analysis mode.

## 4. Generalized Proposal (Provider-Agnostic)

To extend this feature to other providers, the Ollama-specific gating can be removed.

### 4.1. Key Mechanisms

1. **CLI Flag:** The `--json-response` flag remains the sole controller for the feature.
2. **Generalized Logic:** The `if provider is Provider.OLLAMA` checks are removed, allowing the `response_format` to be passed to any configured provider via the `dspy.LM` constructor.

### 4.2. Considerations & Caveats

- **Provider Capability:** The success of this feature depends on both the DSPy provider implementation and the underlying model's ability to generate valid JSON. While the `response_format` parameter instructs the model, it does not guarantee schema conformance, which still relies on the model's instruction-following capabilities.

## 5. Final Proposed Code (Provider-Agnostic)

The following represents the final proposed code structure for a generalized implementation.

```python
# In dspy_file/analyze_file_cli.py

# 1. In build_parser()
parser.add_argument(
    "--json-response",
    action="store_true",
    dest="json_response",
    help="Request a JSON response using a schema (if supported by the provider's DSPy handler).",
)

# 2. In configure_model()
def configure_model(
    # ...,
    response_format: dict[str, Any] | None = None,
):
    lm_kwargs: dict[str, Any] = {"streaming": False, "cache": False}

    if response_format:
        lm_kwargs["response_format"] = response_format

    if provider is Provider.OLLAMA:
        # ...
    else:
        # ...

    lm = dspy.LM(identifier, **lm_kwargs)
    dspy.configure(lm=lm)

# 3. In main()
# ...
analysis_mode = AnalysisMode(args.mode)
response_format = None
if args.json_response:
    schema_filename = f"{analysis_mode.value}.schema.json"
    schema_path = Path(__file__).parent / "prompts" / schema_filename
    try:
        with schema_path.open("r", encoding="utf-8") as f:
            schema = json.load(f)
        response_format = {
            "type": "json_schema",
            "json_schema": {"schema": schema},
        }
    except Exception as e:
        print(f"Warning: Could not load schema from {schema_path}. Error: {e}")

configure_model(..., response_format=response_format)
# ...
```
