# Dotfiles

A comprehensive dotfiles repository containing configuration files and setup scripts for development tools, shell environments, editors, and terminals.

## What's Included

This repository provides curated configurations for:

- **Shell**: Zsh with Oh My Zsh, plugins, aliases, and custom theme
- **Editors**: Neovim with Lazy.nvim plugin manager and extensive plugin ecosystem
- **Version Control**: Git configuration with hooks and aliases
- **Terminals**: Kitty, Ghostty, Hyper, Tmux configurations
- **Tools**: Claude Code, Vim, PHP/Laravel, ctags, EditorConfig
- **Utilities**: Custom scripts (journal, task manager)

## Quick Start

### Prerequisites

- Bash shell
- Git
- (Optional) Neovim, Node.js, Python, PHP/Composer for full features

### Installation

Clone the repository and run the install script:

```bash
git clone https://github.com/itguy614/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The install script will:

1. Create necessary directories (`~/.config`, `~/.local/bin`, `~/.vim`)
2. Symlink all configuration files to appropriate `$HOME` locations
3. Install Oh My Zsh (if not already present)
4. Set up OS-specific git configuration
5. Install additional dependencies

**Note**: The script uses symlinks, not copies. Edit configurations directly in the repository, and changes take effect immediately in `$HOME`.

## Repository Structure

```
dotfiles/
├── install                    # Main installation script
├── README.md                  # This file
├── CLAUDE.md                  # Claude Code-specific guidance
├── claude/                    # Claude Code settings & hooks
├── nvim/                      # Neovim configuration
├── zsh/                       # Zsh shell configuration
├── git/                       # Git configuration (with OS-specific variants)
├── vim/                       # Vim configuration
├── tmux/                      # Tmux configuration
├── kitty/                     # Kitty terminal configuration
├── ghostty/                   # Ghostty terminal configuration
├── hyper/                     # Hyper terminal configuration
├── ctags/                     # Ctags configuration
├── editorconfig/              # EditorConfig settings
├── php/                       # PHP configuration
└── scripts/                   # Utility scripts
```

## Configuration Highlights

### Shell (Zsh)

- **Theme**: Gallifrey
- **Plugins**: git, npm, python, vi-mode, zsh-autosuggestions, tmux, web-search
- **Aliases**: Extensive shortcuts for git, PHP/Laravel, npm, and file navigation
  - `p` - Quick jump to `~/code`
  - `v`/`vim` - Open Neovim
  - `g`, `ga`, `gb`, `gc`, `gp`, `gs`, `gl` - Git shortcuts
  - `art`, `tinker`, `migrate`, `make:*` - Laravel shortcuts
  - `c`, `cr`, `cu`, `cda` - Composer shortcuts

### Editor (Neovim)

- **Plugin Manager**: Lazy.nvim (modern, zero-config)
- **Key Features**:
  - LSP configuration for multiple languages
  - Fuzzy finding with Telescope
  - Tree-sitter syntax highlighting
  - GitHub Copilot integration
  - Git integration with Gitsigns
  - File explorer with nvim-tree
  - Autocompletion with nvim-cmp
- **Color Schemes**: Catppuccin, Nord, Tokyo Night

### Git

- **Features**: Global aliases, commit hooks, cross-platform configuration
- **OS-Specific**: Separate configs for Linux, macOS, and Windows
- **Hooks**: Automatic commit message generation

### Claude Code

- **Model**: Claude Haiku for speed and cost efficiency
- **Permissions**: Configured for safety (read/write allowed, delete/sudo denied)
- **Hooks**: Auto-formatting, type checking, validation
  - Prettier for JS/TS/JSON
  - Black & flake8 for Python
  - TypeScript type checking
  - JSON validation

## Customization

### Update Aliases

Edit `zsh/aliases` and reload:

```bash
source ~/.aliases
```

### Update Neovim Config

Edit files in `nvim/lua/user/`:

- `options.lua` - Editor settings
- `keymaps.lua` - Key bindings
- `plugins.lua` - Plugin specifications
- `plugins/*.lua` - Individual plugin configurations

### Update Claude Code Settings

Edit `claude/settings.json` to:

- Change the AI model (haiku/sonnet/opus)
- Modify permissions and hooks
- Configure environment variables

See `claude/settings.md` for detailed documentation.

### Update Git Config

Edit `git/gitconfig` (main) or platform-specific files:

- `git/gitconfig.linux`
- `git/gitconfig.macos`
- `git/gitconfig.windows`

## System Requirements

| Tool            | Required? | Notes                          |
| --------------- | --------- | ------------------------------ |
| Bash            | Yes       | For install script             |
| Git             | Yes       | For version control            |
| Zsh             | No        | For shell configuration        |
| Neovim          | No        | For editor configuration       |
| Node.js/npm     | No        | For npm aliases, plugin mgmt   |
| Python          | No        | For Python plugins, linters    |
| PHP/Composer    | No        | For Laravel aliases            |
| Oh My Zsh       | No        | Auto-installed by install script |

## Updating

To pull the latest changes from the repository:

```bash
cd ~/.dotfiles
git pull
```

Since configurations are symlinked, updates take effect immediately.

## Important Notes

- **Symlinks**: The install script creates symlinks. Edit configurations in the repository, not in `$HOME`.
- **OS-Specific Config**: Git and Zsh configurations include platform-specific variants. The install script handles detection automatically.
- **Security**: Claude Code settings prioritize security (e.g., .env files are protected, git push is denied).
- **Hooks**: File edits trigger auto-formatting and validation via hooks defined in `claude/settings.json`.

## Troubleshooting

### Install script fails

Ensure you have execute permissions:

```bash
chmod +x install
```

### Symlinks not working

Verify the script ran without errors:

```bash
~/.dotfiles/install
```

### Shell aliases not available

Reload your shell configuration:

```bash
exec zsh
```

Or source directly:

```bash
source ~/.zshrc
```

## Contributing

This is a personal dotfiles repository, but you're welcome to fork and customize for your own use.

## License

Personal dotfiles repository. Feel free to use as a reference or fork for your own setup.

## Resources

- [Oh My Zsh](https://ohmyz.sh/)
- [Neovim](https://neovim.io/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Zsh Documentation](https://www.zsh.org/)
- [Git Documentation](https://git-scm.com/doc)
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
- [Ghostty Terminal](https://mitchellh.com/ghostty)
