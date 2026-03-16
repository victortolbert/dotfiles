# dotfiles

Vic's terminal and dev environment configuration.

## Machines
- **milton** — Mac mini (always-on server, OpenClaw)
- **peter** — Personal MacBook (primary dev)

## What's here

| Path | Purpose |
|------|---------|
| `ghostty/config` | Ghostty terminal (Cobalt2, JetBrains Mono, splits, visor) |
| `zsh/.zshrc` | Main ZSH config (oh-my-zsh, fzf, Java, paths, sources .zsh_aliases) |
| `zsh/.zsh_aliases` | 497-line consolidated aliases & functions (navigation, git, npm/pnpm/bun, docker, AEM, python/uv, helpers) |
| `zsh/custom/themes/cobalt2.zsh-theme` | Oh-My-ZSH Cobalt2 theme |
| `git/.gitconfig` | Git aliases, colors, config |
| `vscode/` | VS Code settings, keybindings |
| `Brewfile` | Homebrew formulae + casks (253 from milton) |
| `install.sh` | Symlink installer (backs up existing files) |

### File structure
```
dotfiles/
├── Brewfile
├── README.md
├── install.sh
├── ghostty/
│   └── config
├── git/
│   └── .gitconfig
├── vscode/
│   ├── settings.json
│   └── keybindings.json
└── zsh/
    ├── .zshenv             ← sourced by ALL zsh (machine-aware 1Password config)
    ├── .zshrc              ← sources ~/.zsh_aliases + machine-aware op read
    ├── .zsh_aliases        ← 497 lines of aliases & functions
    └── custom/
        └── themes/
            └── cobalt2.zsh-theme
```

### Machine behavior

| | Milton (server) | Peter (laptop) |
|---|---|---|
| **1Password** | Service account, no Touch ID | Desktop app + Touch ID |
| **API keys** | Auto-loaded at shell startup | `load-secrets` alias on demand |
| **`.zshrc.local`** | Has `OP_SERVICE_ACCOUNT_TOKEN` | Doesn't exist (not needed) |
| **`.zshenv`** | Sets `OP_BIOMETRIC_UNLOCK_ENABLED=false` | Skips (hostname check) |

## Install

```bash
git clone https://github.com/victortolbert/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
./install.sh
```

The installer backs up existing files before symlinking.

## Secrets

No API keys in this repo. Secrets are managed via 1Password CLI:

```bash
export OPENAI_API_KEY=$(op read "op://OpenClaw/OpenAI/credential")
```

### Machine-specific config (`~/.zshrc.local`)

The `.zshrc` sources `~/.zshrc.local` at the end if it exists. Use this file for
machine-specific secrets and config that shouldn't be in the repo.

Create it on each machine:

```bash
# ~/.zshrc.local — not tracked in git
export OP_SERVICE_ACCOUNT_TOKEN="ops_..."   # needed for `op read` calls
# Add any other machine-specific overrides here
```

## Brew restore

```bash
brew bundle install --file=Brewfile
```
