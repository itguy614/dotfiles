# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **dotfiles repository** containing configuration files for development tools, shell environment, editors, and terminals. The repository is organized by tool/application, with each directory containing related configuration files.

## Repository Structure

- **`install`** - Main installation script that symlinks all dotfiles to `$HOME`
- **`claude/`** - Claude Code settings and configuration
  - `settings.json` - Primary Claude Code settings (permissions, hooks, model, etc.)
  - `settings.md` - Documentation for settings.json options
  - `statusline.sh` - Custom status line command for Claude Code
- **`nvim/`** - Neovim configuration
  - `init.lua` - Main entry point, loads plugins and user config
  - `lua/user/plugins.lua` - Lazy package manager plugin specs
  - `lua/user/options.lua` - Neovim options and settings
  - `lua/user/keymaps.lua` - Key bindings
  - `lua/user/plugins/` - Individual plugin configurations
- **`zsh/`** - Zsh shell configuration
  - `zshrc` - Main shell config (theme, plugins, environment setup)
  - `aliases` - Command aliases (git, PHP, Laravel, development shortcuts)
  - `paths` - PATH configuration
- **`git/`** - Git configuration
  - `gitconfig` - Main git config
  - `gitconfig.linux` / `gitconfig.macos` - OS-specific overrides
  - `gitignore` - Global gitignore patterns
  - `git_template/hooks/prepare-commit-msg` - Git commit hooks
- **`vim/`**, **`tmux/`**, **`kitty/`**, **`ghostty/`**, **`hyper/`** - Terminal & editor configs
- **`ctags/`**, **`editorconfig/`**, **`php/`** - Tool-specific config files
- **`scripts/`** - Utility scripts (journal, `t` task manager)

## Installation & Setup

### Install All Dotfiles
```bash
./install
```

The script:
1. Creates necessary directories (`~/.config`, `~/.local/bin`, `~/.vim`)
2. Symlinks all dotfiles to appropriate `$HOME` locations
3. Installs dependencies (Oh My Zsh, Vundle for Vim, zsh plugins)
4. Sets up OS-specific git config based on platform (Linux/macOS/Windows)

### OS Detection
The install script detects the operating system and symlinks the appropriate git config:
- Linux → `git/gitconfig.linux`
- macOS → `git/gitconfig.macos`
- Windows/MSYS → `git/gitconfig.windows`

## Key Development Tools & Commands

### Claude Code Settings
Located in `claude/settings.json`. Key configurations:
- **Model**: `haiku` (Claude Haiku 3.5 for speed/cost)
- **Permissions**: Allows file read/write, git operations, npm/yarn, web fetching
- **Denied**: `.env` files, `node_modules/`, `build/` dirs, `rm/sudo/curl/wget` commands, git push
- **Hooks**: 
  - Auto-format with Prettier (Edit/Write)
  - TypeScript type checking (Edit *.ts/*.tsx)
  - Python Black formatting & flake8 linting (Edit/Write *.py)
  - JSON validation with jq (Edit/Write *.json)
  - .env file protection (PreToolUse Read)
  - Session start notification

### Neovim Configuration
- **Plugin Manager**: Lazy.nvim (modern, fast)
- **Color Schemes**: Catppuccin, Nord, Tokyo Night
- **Key Plugins**: 
  - LSP config for language servers
  - Completion (cmp) with multiple sources
  - Telescope for fuzzy finding
  - Treesitter for syntax highlighting
  - nvim-tree for file explorer
  - GitHub Copilot integration
  - Git integration (gitsigns)
  - UI enhancements (lualine, bufferline, barbecue, scrollbar)

### Zsh Shell
- **Theme**: Gallifrey
- **Key Plugins**: git, npm, python, vi-mode, zsh-autosuggestions, tmux, web-search
- **Notable Aliases**:
  - `p` - cd to ~/code
  - `v`/`vim` - nvim
  - Git: `g`, `ga`, `gb`, `gc`, `gp`, `gs`, `gl`, etc. (comprehensive git shortcuts)
  - PHP/Laravel: `art`, `tinker`, `migrate`, `make:controller`, etc.
  - Composer: `c`, `cr`, `cu`, `cda`
  - Utilities: `..` (go up), `...` (go up 2), etc.

## Configuration Notes

### File Permissions in Claude Code
The repository is locked down for safety. Claude Code:
- ✅ **Can**: Read/write most files, run git commands, run npm/yarn scripts, fetch web content
- ❌ **Cannot**: Read .env files, delete files, use sudo/curl/wget, push to git, publish packages, modify kubernetes/terraform configs

### Hooks & Auto-Formatting
All file edits/writes trigger auto-formatting and validation via hooks defined in `claude/settings.json`:
- Prettier formatting for JS/TS/JSON
- Black & flake8 for Python
- TypeScript type checking
- JSON validation

### Installation Requirements
- Bash shell
- Git
- Oh My Zsh (auto-installed if not present)
- Node.js/npm (for npm aliases, Neovim plugin management)
- Python (for Python plugins, black/flake8)
- PHP/Composer (for Laravel aliases)
- Neovim with Lua support (for nvim configs)

## Editing Configurations

### Update Claude Code Settings
Edit `claude/settings.json` to:
- Change the AI model (haiku/sonnet/opus)
- Add/remove permissions
- Modify hooks or add new ones
- Configure environment variables

See `claude/settings.md` for detailed documentation.

### Update Shell Aliases
Edit `zsh/aliases` and reload with: `source ~/.aliases`

### Update Neovim Config
Edit files in `nvim/lua/user/`:
- `options.lua` - Editor settings
- `keymaps.lua` - Key bindings
- `plugins.lua` - Plugin specs
- `plugins/*.lua` - Individual plugin configs

Plugins use Lazy.nvim - see `nvim/lazy-lock.json` for current versions.

## Important Conventions

- **Symlinks Only**: The install script uses symlinks, not copies. Edit files in the dotfiles repo directly; changes reflect immediately in `$HOME`
- **OS-Specific Config**: Git and zsh configs include OS-specific variants (check for `.linux`/`.macos` suffixes)
- **Ignored Files**: `nvim/lazy-lock.json` and `*.bak` are gitignored (see `.gitignore`)
- **Hooks Override**: Claude Code settings in this repo prioritize security over convenience (e.g., denying .env reads)
