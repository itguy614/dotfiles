# Claude Code Settings Documentation

This document explains the configuration options in `settings.json`.

## Overview

**Location**: `~/.claude/settings.json` (user-wide) or `.claude/settings.json` (project-specific)

**Configuration Hierarchy** (higher overrides lower):
1. Enterprise settings (`/etc/claude-code/managed-settings.json`)
2. User settings (`~/.claude/settings.json`)
3. Project settings (`.claude/settings.json`)
4. Local project settings (`.claude/settings.local.json`) - gitignored
5. CLI flags (highest priority)

**Documentation**: https://docs.claude.com/en/docs/claude-code/settings

---

## Model Configuration

### `model`
Specify which Claude model to use for this session/project.

**Available models:**
- `claude-sonnet-4-5-20250929` (Claude Sonnet 4.5 - recommended, balanced)
- `claude-sonnet-4-20250514` (Claude Sonnet 4)
- `claude-opus-4-1` (Claude Opus 4.1 - most capable)
- `claude-haiku-3-5-20241022` (Claude Haiku - fastest, cheapest)

You can also use aliases: `sonnet`, `opus`, `haiku`

### `maxTokens`
Maximum number of tokens in Claude's response.

- **Range**: 1 to 8192 (depending on model)
- **Default**: 4096
- **Note**: Higher values allow longer responses but consume more tokens

---

## Permissions System

Controls what tools and operations Claude Code can perform. This is the **PRIMARY security mechanism** for Claude Code.

### Permission Format

- `ToolName` - Allow/deny the entire tool
- `ToolName(*)` - Allow/deny with any arguments
- `ToolName(pattern)` - Allow/deny operations matching the pattern

### Available Tools

- **Read**: Read file contents
- **Write**: Create new files
- **Edit**: Modify existing files
- **MultiEdit**: Edit multiple files at once
- **Bash**: Execute shell commands
- **Glob**: List files matching patterns
- **Grep**: Search file contents
- **LS**: List directory contents
- **List**: Alternative listing tool
- **Find**: Search for files
- **Search**: Search codebase
- **Task**: Create subtasks (for subagents)
- **Agent**: Delegate to subagents
- **WebFetch**: Fetch web content
- **WebSearch**: Search the web
- **NotebookRead**: Read Jupyter notebooks
- **NotebookEdit**: Edit Jupyter notebooks

### `permissions.allow`

Operations explicitly permitted. Patterns support wildcards (`*`) and glob patterns (`**`).

**Examples:**
```json
"Read"              // Allow reading any file
"Read(src/**)"      // Only allow reading in src/ directory
"Read(*.json)"      // Only allow reading JSON files
"Bash(git *)"       // Allow all git commands
"Bash(npm run test:*)"  // Allow npm test scripts only
```

### `permissions.deny`

Operations explicitly blocked (overrides allow rules). These are checked AFTER allow rules and take precedence.

**Always protect sensitive files:**
- `.env` and `.env.*` files
- `secrets/` directory
- `credentials.json` files
- `node_modules/` and build directories
- Production configurations

**Block dangerous bash commands:**
- `rm` (file deletion)
- `sudo` (elevated privileges)
- `curl` and `wget` (can download/execute)
- `chmod` and `chown` (permission changes)
- Deploy and publish commands
- `git push` (optional)

### `permissions.ask`

Operations that require explicit user confirmation each time. These will always prompt, even if in the allow list.

**Examples:**
```json
"Write(./src/**)"       // Confirm all file creations
"Bash(git commit:*)"    // Confirm all commits
"Bash(npm install:*)"   // Confirm package installations
```

---

## Environment Variables

Set environment variables for Claude Code sessions. These are available to all bash commands and MCP servers.

**Important**: Do not put sensitive values here - use `.env` files or system environment variables instead.

**Examples:**
```json
"env": {
  "NODE_ENV": "development",
  "DEBUG": "true",
  "LOG_LEVEL": "info",
  "CLAUDE_CODE_ENABLE_TELEMETRY": "0"
}
```

---

## Hooks System

Run custom commands at different points in Claude Code's lifecycle. Hooks execute as shell commands and can control execution flow.

### Available Hook Types

- **PreToolUse**: Before any tool executes
- **PostToolUse**: After a tool completes
- **Notification**: When Claude sends notifications
- **Stop**: When Claude finishes responding
- **SessionStart**: When a Claude Code session begins
- **SessionEnd**: When a session ends

### Exit Codes

- **0**: Success, continue normally
- **1**: Failure, but continue
- **2**: Block the operation (for PreToolUse hooks)

### Available Environment Variables

- `$CLAUDE_FILE_PATHS`: Space-separated list of file paths
- `$CLAUDE_PROJECT_DIR`: Absolute path to project root
- `stdin`: JSON data about the hook event

### Common Hook Examples

**Code Formatting:**
```json
{
  "matcher": "Edit|Write",
  "hooks": [{
    "type": "command",
    "command": "prettier --write \"$CLAUDE_FILE_PATHS\" 2>/dev/null || true"
  }]
}
```

**TypeScript Type Checking:**
```json
{
  "matcher": "Edit(*.ts)|Edit(*.tsx)",
  "hooks": [{
    "type": "command",
    "command": "if [[ \"$CLAUDE_FILE_PATHS\" =~ \\.(ts|tsx)$ ]]; then npx tsc --noEmit --skipLibCheck \"$CLAUDE_FILE_PATHS\" 2>&1 || echo '⚠️  TypeScript errors detected'; fi"
  }]
}
```

**Python Formatting:**
```json
{
  "matcher": "Edit(*.py)|Write(*.py)",
  "hooks": [
    {
      "type": "command",
      "command": "python -m black \"$CLAUDE_FILE_PATHS\" 2>/dev/null || true"
    },
    {
      "type": "command",
      "command": "python -m flake8 \"$CLAUDE_FILE_PATHS\" 2>/dev/null || true"
    }
  ]
}
```

**Security Validation:**
```json
{
  "matcher": "Read",
  "hooks": [{
    "type": "command",
    "command": "if [[ \"$CLAUDE_FILE_PATHS\" =~ \\.env ]]; then echo 'BLOCKED: Cannot read .env files'; exit 2; fi"
  }]
}
```

**JSON Validation:**
```json
{
  "matcher": "Edit(*.json)|Write(*.json)",
  "hooks": [{
    "type": "command",
    "command": "for file in $CLAUDE_FILE_PATHS; do jq empty \"$file\" 2>/dev/null || echo \"⚠️  Invalid JSON in $file\"; done"
  }]
}
```

---

## Plugin System

Enable or disable Claude Code plugins. Plugins extend functionality with custom commands, agents, hooks, and MCP servers.

### `enabledPlugins`

Format: `"plugin-name@marketplace-name": true/false`

**Examples:**
```json
"enabledPlugins": {
  "code-formatter@team-tools": true,
  "deployment-tools@team-tools": true,
  "experimental-features@personal": false
}
```

### `extraKnownMarketplaces`

Define additional plugin marketplaces.

**Example:**
```json
"extraKnownMarketplaces": {
  "company-tools": {
    "source": "github",
    "repo": "company/claude-plugins"
  }
}
```

---

## Sandbox Configuration

Configure advanced sandboxing behavior for bash commands. Sandboxing isolates commands from your filesystem and network.

### `sandbox.enabled`
Enable sandboxing (requires compatible OS).

### `sandbox.autoAllowBashIfSandboxed`
When true, bash commands run in sandbox without permission prompts.

### `sandbox.excludedCommands`
Commands excluded from sandbox (run with full system access).

**Examples:**
- `docker` - Docker needs full access
- `kubectl` - Kubernetes CLI needs full access
- `aws` - AWS CLI needs full access

### `sandbox.network`

**`allowUnixSockets`**: Allow access to Unix domain sockets
```json
"allowUnixSockets": ["/var/run/docker.sock"]
```

**`allowDomains`**: Allow network access to specific domains
```json
"allowDomains": ["api.example.com", "*.github.com"]
```

**`blockDomains`**: Block network access to specific domains
```json
"blockDomains": ["malicious-site.com"]
```

---

## User Interface

### `spinnerTipsEnabled`
Enable/disable helpful tips during loading animations.

### `statusLine`
Custom status line format (supports variables).

**Available variables:**
- `${PROJECT_NAME}` - Project name
- `${GIT_BRANCH}` - Current git branch
- `${MODEL}` - Current model

**Example:**
```json
"statusLine": "Project: ${PROJECT_NAME} | Branch: ${GIT_BRANCH}"
```

---

## Advanced Settings

### `autoAcceptPermissions`
Auto-accept permissions. **DANGEROUS** - use with caution. Only use this in isolated/development environments.

### `projectName`
Default project name (used in status line).

### `defaultBranch`
Default git branch to assume (e.g., `main` or `master`).

### `testCommand`
Custom test command for the project (e.g., `npm test`, `pytest`).

### `lintCommand`
Custom lint command for the project (e.g., `npm run lint`, `flake8`).

### `buildCommand`
Custom build command for the project (e.g., `npm run build`, `cargo build`).

---

## Metadata

Optional metadata for tracking configuration versions and descriptions.

```json
"_metadata": {
  "version": "1.0.0",
  "description": "Claude Code settings for [project name]",
  "lastModified": "2025-10-23",
  "author": "Your Name"
}
```
