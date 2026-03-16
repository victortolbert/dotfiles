# dotfiles

Vic's terminal and dev environment configuration.

## Machines
- **milton** — Mac mini (always-on server, OpenClaw)
- **peter** — Personal MacBook (primary dev)

## What's here

| Path | Purpose |
|------|---------|
| `ghostty/config` | Ghostty terminal (Cobalt2, JetBrains Mono, splits, visor) |
| `zsh/.zshrc` | Main ZSH config (oh-my-zsh, fzf, paths) |
| `zsh/custom/` | ZSH aliases, env, themes |
| `git/.gitconfig` | Git aliases, colors, config |
| `vscode/` | VS Code settings, keybindings, extensions |
| `Brewfile` | Homebrew formulae + casks |
| `install.sh` | Symlink installer |

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

## Brew restore

```bash
brew bundle install --file=Brewfile
```
