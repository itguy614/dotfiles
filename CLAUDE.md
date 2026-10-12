# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **dotfiles repository** containing configuration files for development tools, shell environment, editors, and terminals. The repository is organized by tool/application, with each directory containing related configuration files.

## Repository Structure

- **`install`** - Main installation script that symlinks all dotfiles to `$HOME`
  - Flags: `--skip-deps` (link only), `--deps-only`, `--force` (back up and replace non-symlinks)
  - Never deletes a real file; it reports and skips unless `--force` is passed
- **`lib/platform.sh`** - Platform detection shared by `install`, scripts, and shell rc files
  - `dotfiles_platform_chain` emits e.g. `omarchy arch linux`, `ubuntu debian linux`, `macos`
  - `dotfiles_variant <dir> <base>` resolves the most specific `<base>.<platform>` file
- **`shell/`** - Shell-agnostic configuration, sourced by zsh (and any future bash rc)
  - `env.sh` - `PATH` helpers, `EDITOR`, exported environment
  - `aliases.sh` - every alias (git, Laravel, composer, navigation)
  - `functions.sh` - `db`, `gi`, and friends
- **`starship/`** - Prompt config, linked on every platform including Omarchy
  - Uses ANSI colour names, not hex, so the prompt follows the terminal palette (this is what makes it track `omarchy-theme-set` — nothing themes the file itself)
- **`omarchy/`** - Omarchy desktop overrides (`hypr/`); only files diverging from `/etc/skel`
- **`claude/`** - Claude Code settings and configuration
  - `settings.json` - Primary Claude Code settings (permissions, hooks, model, etc.)
  - `settings.md` - Documentation for settings.json options
- **`nvim/`** - Neovim configuration
  - `init.lua` - Main entry point, loads plugins and user config
  - `lua/user/plugins.lua` - Lazy package manager plugin specs
  - `lua/user/options.lua` - Neovim options and settings
  - `lua/user/keymaps.lua` - Key bindings
  - `lua/user/plugins/` - Individual plugin configurations
- **`zsh/`** - Zsh-specific configuration
  - `zshrc` - Main shell config (options, plugins, load order, keybindings)
  - `zshrc.omarchy` / `zshrc.linux` / `zshrc.macos` - Per-platform layers, linked to `~/.zshrc.os`
  - `tmux` - Tmux auto-attach and session helpers, linked to `~/.tmux.zsh`
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
1. Resolves the platform chain via `lib/platform.sh`
2. Creates necessary directories (`~/.config`, `~/.local/bin`, `~/.vim`)
3. Symlinks all dotfiles to appropriate `$HOME` locations, skipping (not deleting) any real file it did not create
4. Links the most specific per-platform variant of each config
5. Installs dependencies (Oh My Zsh, its plugins, Vundle, and native packages on Arch)

Fonts install separately via `scripts/install-nerd-fonts`, which dispatches on
the same platform chain (brew casks / the `nerd-fonts` pacman group / GitHub
release tarballs).

### Platform Detection
`lib/platform.sh` reads `/etc/os-release` and builds an ordered chain, most
specific first. `install` links the first `<name>.<platform>` variant that
exists along that chain, falling back to `<name>.default`:

| System | Chain | `~/.zshrc.os` resolves to |
| ------ | ----- | ------------------------- |
| Omarchy | `omarchy arch linux` | `zsh/zshrc.omarchy` |
| Arch | `arch linux` | `zsh/zshrc.linux` |
| Ubuntu | `ubuntu debian linux` | `zsh/zshrc.linux` |
| macOS | `macos` | `zsh/zshrc.macos` |

The same mechanism drives `~/.gitconfig.os`, `~/.tmux.theme.conf`, and
`~/.config/ghostty/platform.conf`.

## Key Development Tools & Commands

### Claude Code Settings
Located in `claude/settings.json`. Key configurations:
- **Model**: set in `claude/settings.json` (currently `opus[1m]`)
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
Edit `shell/aliases.sh` (shell-agnostic) and reload with `exec zsh`.
Zsh-only behaviour — `setopt`, `bindkey`, `zstyle`, the `plugins` array —
belongs in `zsh/zshrc` instead.

### Update Neovim Config
Edit files in `nvim/lua/user/`:
- `options.lua` - Editor settings
- `keymaps.lua` - Key bindings
- `plugins.lua` - Plugin specs
- `plugins/*.lua` - Individual plugin configs

Plugins use Lazy.nvim - see `nvim/lazy-lock.json` for current versions.

## Important Conventions

- **Symlinks Only**: The install script uses symlinks, not copies. Edit files in the dotfiles repo directly; changes reflect immediately in `$HOME`
- **Never `rm -rf` a target in `install`**: use the `link` helper, which refuses to destroy files it did not create. Omarchy ships real configs at `~/.config/ghostty` and `~/.config/hypr`
- **Shell load order**: Oh My Zsh → platform layer (`~/.zshrc.os`) → `shell/*.sh`. The last one wins collisions, which is how this repo's aliases beat Omarchy's
- **Omarchy**: never run `omarchy-setup-zsh` — it regenerates `~/.zshrc` from its own template and replaces our symlink. Omarchy owns theming; configs follow `~/.local/state/omarchy/current/theme/`
- **OS-Specific Config**: Git and zsh configs include OS-specific variants (check for `.linux`/`.macos` suffixes)
- **Ignored Files**: `nvim/lazy-lock.json` and `*.bak` are gitignored (see `.gitignore`)
- **Hooks Override**: Claude Code settings in this repo prioritize security over convenience (e.g., denying .env reads)
