You're asking about how the **gemini-cli provider** was integrated into claude-task-master. <cite/>

## Integration Architecture

The gemini-cli provider integration consists of three main components:

### 1. Provider Class Implementation

The `GeminiCliProvider` class in `src/ai-providers/gemini-cli.js` extends `BaseAIProvider` and wraps the `ai-sdk-provider-gemini-cli` npm package. [1](#1-0)

The provider dynamically loads the `ai-sdk-provider-gemini-cli` module to avoid hard dependencies: [2](#1-1)

### 2. Authentication Handling

The key innovation is **OAuth-based authentication** instead of API keys. The `getClient()` method configures authentication to use `oauth-personal` by default, which leverages the user's existing `gemini` CLI authentication: [3](#1-2)

This means users authenticate once via `gemini` CLI and Task Master automatically uses those credentials. <cite/>

### 3. JSON Response Handling

Gemini CLI has a tendency to return conversational text instead of pure JSON. The provider implements special handling to extract JSON from conversational responses: [4](#1-3)

The provider also adds JSON enforcement prompts and simplifies complex prompts before sending them to Gemini: [5](#1-4)

### 4. Registration in the System

The provider is registered in the central provider registry at `scripts/modules/ai-services-unified.js`: [6](#1-5)

And exported from the provider index: [7](#1-6)

### 5. CLI Configuration Support

Users can configure gemini-cli via the `models` command with the `--gemini-cli` flag: [8](#1-7)

## Notes

The integration was added in PR [#1163](https://github.com/eyaltoledano/claude-task-master/pull/1163) (commit [37af0f1](https://github.com/eyaltoledano/claude-task-master/commit/37af0f191227a68d119b7f89a377bf932ee3ac66)) to enable codebase-aware task generation. [9](#1-8)  The provider supports two models: `gemini-2.5-pro` and `gemini-2.5-flash`, both with zero cost since they use OAuth authentication. [10](#1-9)

Wiki pages you might want to explore:

- [AI Integration (eyaltoledano/claude-task-master)](/wiki/eyaltoledano/claude-task-master#7)
- [AI Provider Configuration (eyaltoledano/claude-task-master)](/wiki/eyaltoledano/claude-task-master#7.1)

### Citations

**File:** src/ai-providers/gemini-cli.js (L15-26)

```javascript
async function loadGeminiCliModule() {
 if (!createGeminiProvider) {
  try {
   const mod = await import('ai-sdk-provider-gemini-cli');
   createGeminiProvider = mod.createGeminiProvider;
  } catch (err) {
   throw new Error(
    "Gemini CLI SDK is not installed. Please install 'ai-sdk-provider-gemini-cli' to use the gemini-cli provider."
   );
  }
 }
}
```

**File:** src/ai-providers/gemini-cli.js (L28-32)

```javascript
export class GeminiCliProvider extends BaseAIProvider {
 constructor() {
  super();
  this.name = 'Gemini CLI';
 }
```

**File:** src/ai-providers/gemini-cli.js (L55-82)

```javascript
 async getClient(params) {
  try {
   // Load the Gemini CLI module dynamically
   await loadGeminiCliModule();
   // Primary use case: Use existing gemini CLI authentication
   // Secondary use case: Direct API key (for compatibility)
   let authOptions = {};

   if (params.apiKey && params.apiKey !== 'gemini-cli-no-key-required') {
    // API key provided - use it for compatibility
    authOptions = {
     authType: 'api-key',
     apiKey: params.apiKey
    };
   } else {
    // Expected case: Use gemini CLI authentication via OAuth
    authOptions = {
     authType: 'oauth-personal'
    };
   }

   // Add baseURL if provided (for custom endpoints)
   if (params.baseURL) {
    authOptions.baseURL = params.baseURL;
   }

   // Create and return the provider
   return createGeminiProvider(authOptions);
```

**File:** src/ai-providers/gemini-cli.js (L418-437)

```javascript
   // For gemini-cli, simplify complex prompts before processing
   let processedMessages = params.messages;
   if (enforceJsonOutput) {
    processedMessages = this._simplifyJsonPrompts(params.messages);
   }

   // Extract system messages for separate handling with optional JSON enforcement
   const { systemPrompt, messages } = this._extractSystemMessage(
    processedMessages,
    { enforceJsonOutput }
   );

   // Debug the final system prompt being sent
   log('debug', `${this.name} final system prompt:`, {
    systemPromptLength: systemPrompt ? systemPrompt.length : 0,
    systemPromptPreview: systemPrompt
     ? systemPrompt.substring(0, 300) + '...'
     : 'none',
    finalMessageCount: messages.length
   });
```

**File:** src/ai-providers/gemini-cli.js (L448-475)

```javascript
   // If we detected a JSON request and gemini-cli returned conversational text,
   // attempt to extract JSON from the response
   let finalText = result.text;
   if (enforceJsonOutput && result.text && !this._isValidJson(result.text)) {
    log(
     'debug',
     `${this.name} response appears conversational, attempting JSON extraction`
    );

    // Log first 1000 chars of the response to see what Gemini actually returned
    log('debug', `${this.name} raw response preview:`, {
     responseLength: result.text.length,
     responseStart: result.text.substring(0, 1000)
    });

    const extractedJson = this.extractJson(result.text);
    if (this._isValidJson(extractedJson)) {
     log(
      'debug',
      `${this.name} successfully extracted JSON from conversational response`
     );
     finalText = extractedJson;
    } else {
     log(
      'debug',
      `${this.name} JSON extraction failed, returning original response`
     );

```

**File:** scripts/modules/ai-services-unified.js (L72-74)

```javascript
 'claude-code': new ClaudeCodeProvider(),
 'gemini-cli': new GeminiCliProvider(),
 'grok-cli': new GrokCliProvider()
```

**File:** src/ai-providers/index.js (L18-18)

```javascript
export { GeminiCliProvider } from './gemini-cli.js';
```

**File:** scripts/modules/commands.js (L3586-3603)

```javascript
   '--gemini-cli',
   'Allow setting a Gemini CLI model ID (use with --set-*)'
  )
  .addHelpText(
   'after',
   `
Examples:
  $ task-master models                              # View current configuration
  $ task-master models --set-main gpt-4o             # Set main model (provider inferred)
  $ task-master models --set-research sonar-pro       # Set research model
  $ task-master models --set-fallback claude-3-5-sonnet-20241022 # Set fallback
  $ task-master models --set-main my-custom-model --ollama  # Set custom Ollama model for main role
  $ task-master models --set-main anthropic.claude-3-sonnet-20240229-v1:0 --bedrock # Set custom Bedrock model for main role
  $ task-master models --set-main some/other-model --openrouter # Set custom OpenRouter model for main role
  $ task-master models --set-main sonnet --claude-code           # Set Claude Code model for main role
  $ task-master models --set-main gpt-4o --azure # Set custom Azure OpenAI model for main role
  $ task-master models --set-main claude-3-5-sonnet@20241022 --vertex # Set custom Vertex AI model for main role
  $ task-master models --set-main gemini-2.5-pro --gemini-cli # Set Gemini CLI model for main role
```

**File:** CHANGELOG.md (L123-127)

```markdown
- [#1163](https://github.com/eyaltoledano/claude-task-master/pull/1163) [`37af0f1`](https://github.com/eyaltoledano/claude-task-master/commit/37af0f191227a68d119b7f89a377bf932ee3ac66) Thanks [@Crunchyman-ralph](https://github.com/Crunchyman-ralph)! - Enhanced Gemini CLI provider with codebase-aware task generation

  Added automatic codebase analysis for Gemini CLI provider in parse-prd, and analyze-complexity, add-task, udpate-task, update, update-subtask commands
  When using Gemini CLI as the AI provider, Task Master now instructs the AI to analyze the project structure, existing implementations, and patterns before generating tasks or subtasks
  Tasks and subtasks generated by Claude Code are now informed by actual codebase analysis, resulting in more accurate and contextual outputs
```

**File:** scripts/modules/supported-models.json (L85-107)

```json
 "gemini-cli": [
  {
   "id": "gemini-2.5-pro",
   "swe_score": 0.72,
   "cost_per_1m_tokens": {
    "input": 0,
    "output": 0
   },
   "allowed_roles": ["main", "fallback", "research"],
   "max_tokens": 65536,
   "supported": true
  },
  {
   "id": "gemini-2.5-flash",
   "swe_score": 0.71,
   "cost_per_1m_tokens": {
    "input": 0,
    "output": 0
   },
   "allowed_roles": ["main", "fallback", "research"],
   "max_tokens": 65536,
   "supported": true
  }
```
