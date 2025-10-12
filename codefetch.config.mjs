/** @type {import('codefetch').CodefetchConfig} */
export default {
  projectTree: 5,
  tokenLimiter: "truncated",
  defaultPromptFile: "default.md",
  excludeFiles: ["**/*.png", "*.mjs"],
  excludeDirs: [
    "tests",
    "dist",
    ".taskmaster",
    ".cursor",
    ".clinerules",
    ".gemini",
    "docs",
    "codefetch",
    ".venv",
    ".github",
    "scripts",
    "example-data",
    "__pycache__",
    "data",
    "example-data",
    "dspyteach.egg-info"
  ],
};
