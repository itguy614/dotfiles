# Dotfiles

A comprehensive dotfiles repository containing configuration files and setup scripts for development tools, shell environments, editors, and terminals.

## What's Included

This repository provides curated configurations for:

- **Shell**: Zsh with Oh My Zsh, plugins, aliases, and custom theme
- **Editors**: Neovim with Lazy.nvim plugin manager and extensive plugin ecosystem
- **Version Control**: Git configuration with hooks and aliases
- **Terminals**: WezTerm, Kitty, Ghostty, Hyper, Tmux, Screen configurations
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

1. Detect the platform and resolve a **platform chain** (see below)
2. Create necessary directories (`~/.config`, `~/.local/bin`, `~/.vim`)
3. Symlink all configuration files to appropriate `$HOME` locations
4. Link the most specific per-platform variant of each config
5. Install Oh My Zsh, its plugins, and any native packages the platform provides

| Flag | Effect |
| ---- | ------ |
| `--skip-deps` | Link configs only — no sudo, no network |
| `--deps-only` | Install dependencies without touching symlinks |
| `--force` | Back up and replace files the script did not create |

**Note**: The script uses symlinks, not copies. Edit configurations directly in the repository, and changes take effect immediately in `$HOME`.

**The script will never silently delete a real file.** If `~/.config/ghostty/config` (or anything else) exists and is not a symlink we created, it is reported and skipped. Re-run with `--force` to move it to `<name>.backup-<timestamp>` and link over it.

### Platform chain

Detection reads `/etc/os-release` and produces an ordered chain, most specific first:

| System | Chain |
| ------ | ----- |
| Omarchy | `omarchy arch linux` |
| Arch | `arch linux` |
| Ubuntu | `ubuntu debian linux` |
| Fedora | `fedora linux` |
| macOS | `macos` |

Any config can have a `<name>.<platform>` variant, and the first match along the chain wins — so `zsh/zshrc.omarchy` beats `zsh/zshrc.linux` on Omarchy, while Ubuntu falls through to `zsh/zshrc.linux`. A `<name>.default` variant is the last resort.

### Fonts

Nerd Fonts install separately, using whatever each platform packages natively:

```bash
install-nerd-fonts
```

| Platform | Mechanism |
| -------- | --------- |
| macOS | Homebrew casks |
| Arch / Omarchy | the `nerd-fonts` pacman group (72 packages) |
| Ubuntu / Fedora | GitHub release tarballs into `~/.local/share/fonts` |

## Repository Structure

```
dotfiles/
├── install                    # Main installation script
├── README.md                  # This file
├── CLAUDE.md                  # Claude Code-specific guidance
├── lib/                       # Platform detection shared by scripts & shells
├── shell/                     # Shell-agnostic env, aliases, functions
├── claude/                    # Claude Code settings & hooks
├── nvim/                      # Neovim configuration
├── zsh/                       # Zsh-specific configuration
├── starship/                  # Prompt configuration (all platforms)
├── omarchy/                   # Omarchy desktop overrides (Hyprland)
├── git/                       # Git configuration (with OS-specific variants)
├── vim/                       # Vim configuration
├── tmux/                      # Tmux configuration
├── wezterm/                   # WezTerm terminal configuration
├── kitty/                     # Kitty terminal configuration
├── ghostty/                   # Ghostty terminal configuration
├── hyper/                     # Hyper terminal configuration
├── screen/                    # GNU Screen configuration
├── ctags/                     # Ctags configuration
├── editorconfig/              # EditorConfig settings
├── php/                       # PHP configuration
└── scripts/                   # Utility scripts
```

## Configuration Highlights

### Shell (Zsh)

- **Prompt**: Starship (falls back to Oh My Zsh's Gallifrey theme where starship is absent)
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

- **Model**: Set in `claude/settings.json` (currently `opus[1m]`)
- **Permissions**: Configured for safety (read/write allowed, sudo/deploy/publish denied)
- **Hooks**: Auto-formatting, type checking, validation
  - Prettier for JS
  - Black & flake8 for Python
  - TypeScript type checking
  - JSON validation with jq

## Customization

### Update Aliases

Aliases and functions live in `shell/`, not in `zsh/`, so that both zsh and
bash get the same set:

- `shell/env.sh` — `PATH`, `EDITOR`, exported environment
- `shell/aliases.sh` — every alias
- `shell/functions.sh` — `db`, `gi`, and friends

Reload with:

```bash
exec zsh
```

### Update Neovim Config

Edit files in `nvim/lua/user/`:

- `options.lua` - Editor settings
- `keymaps.lua` - Key bindings
- `plugins.lua` - Plugin specifications
- `plugins/*.lua` - Individual plugin configurations

### Update Claude Code Settings

Edit `claude/settings.json` to:

- Change the AI model (haiku/sonnet/opus/etc.)
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
| Starship        | No        | Prompt; installed by pacman on Arch |
| omarchy-zsh     | No        | Omarchy only; installed by pacman |

## Omarchy

Omarchy ships its own opinionated shell and desktop layer and defaults to bash.
These dotfiles integrate with it rather than replacing it.

**Shell.** `omarchy-zsh` is the officially packaged zsh port of Omarchy's bash
layer; `install` pulls it from the `omarchy` repo. `zsh/zshrc.omarchy` sources
it directly from `/usr/share/omarchy-zsh/shell/`.

> Do **not** run `omarchy-setup-zsh`. It regenerates `~/.zshrc` from its own
> template and will replace the symlink this repo installs.

Switch your login shell with `chsh -s /usr/bin/zsh`.

**Load order.** Oh My Zsh first, then the Omarchy layer, then `shell/*.sh`.
Omarchy has to land after Oh My Zsh or Oh My Zsh's git aliases and prompt reset
would clobber it; `shell/*.sh` lands last so this repo's aliases win every
collision. The one alias explicitly removed is Omarchy's `t` (a plain
`tmux attach`), which otherwise shadows the fzf project switcher in
`scripts/t`.

**Runtimes.** Omarchy standardises on mise, so nvm and pyenv stay switched off
there.

**Theming.** Omarchy owns the palette. `omarchy-theme-set` rewrites
`~/.local/state/omarchy/current/theme/`, and these configs follow it.

Note that nothing in Omarchy themes `starship.toml` — it is shipped once via
`/etc/skel` and left alone thereafter, so this repo links its own copy here as
on every other platform. The prompt tracks the theme because the config uses
ANSI colour names rather than hex.


| Target | How |
| ------ | --- |
| Ghostty | `ghostty/platform.omarchy` includes the theme's `ghostty.conf` |
| Kitty | `globinclude` of the theme's `kitty.conf` (a no-op elsewhere) |
| Tmux | `tmux/theme.omarchy` uses ANSI colour names, which follow the terminal |
| Neovim | Not wired up — `nvim/lua/user/plugins/nord-light-brighter.lua` is hand-tuned. To follow Omarchy instead, add `~/.local/state/omarchy/current/theme/neovim.lua` as a lazy.nvim spec |

**Desktop.** `omarchy/hypr/` tracks only the Hyprland files that diverge from
`/etc/skel`. `monitors.lua` is deliberately **not** tracked — output names and
scale are per-machine, and symlinking it would break the display on the next
box.

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
- **Security**: Claude Code settings prioritize security (e.g., sudo/deploy/publish commands are denied, production configs are write-protected).
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
- [WezTerm](https://wezfurlong.org/wezterm/)
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
- [Ghostty Terminal](https://mitchellh.com/ghostty)
