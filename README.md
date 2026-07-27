# dotfiles

Vic's terminal and dev environment configuration.

## Machines
- **milton** — Mac mini (always-on server, OpenClaw)
- **peter** — Personal MacBook (primary dev)
- **brian** — MacBook (primary dev)

## What's here

| Path | Purpose |
|------|---------|
| `zsh/.zshrc` | Main ZSH config (oh-my-zsh, fzf, mise, paths; sources `~/.zsh_aliases` and `~/.zsh_secrets`) |
| `zsh/.zshenv` | Sourced by *all* zsh invocations; dedupes `PATH`, machine-aware 1Password config |
| `zsh/.zsh_aliases` | 563 lines of aliases & functions (navigation, git, npm/pnpm/bun, docker, AEM, python/uv, ffmpeg, helpers) |
| `zsh/custom/themes/cobalt2.zsh-theme` | Oh-My-ZSH Cobalt2 theme |
| `git/.gitconfig` | Git aliases, colors, credential helpers |
| `ghostty/config` | Ghostty terminal (Cobalt2, JetBrains Mono, splits, visor) |
| `iterm2/` | Preferences plist (XML) + a README on why the plist can't just be symlinked |
| `vscode/` | VS Code — settings, keybindings, `mcp.json`, 8 snippet files |
| `vscode-insiders/` | Same for VS Code Insiders, tracked separately |
| `zed/` | Zed settings + `themes/tailwind-css.json` |
| `karabiner/karabiner.json` | Karabiner-Elements key remapping |
| `mise/config.toml` | Runtime pins (ruby 3.3.6, java 21) |
| `macos/defaults.sh` | `defaults write` system tweaks, with `current-defaults-reference.txt` as the extracted baseline |
| `bin/` | `try` (scratch-project launcher), `migrate-fonts`, and `lib/` Ruby helpers |
| `Brewfile` | Homebrew: 27 formulae, 16 casks, 1 tap |
| `Brewfile.bak` | 251-entry snapshot kept when the Brewfile was trimmed for a new Mac (`34b7bce`) |
| `install.sh` | Symlink installer (backs up existing files) |

### File structure
```
dotfiles/
├── Brewfile
├── Brewfile.bak            ← 251-entry pre-trim snapshot
├── README.md
├── install.sh
├── bin/
│   ├── try                 ← scratch-project launcher (`try init` runs in .zshrc)
│   ├── migrate-fonts
│   └── lib/                ← fuzzy.rb, tui.rb
├── ghostty/
│   └── config
├── git/
│   └── .gitconfig
├── iterm2/
│   ├── README.md           ← import/export steps
│   └── com.googlecode.iterm2.plist
├── karabiner/
│   └── karabiner.json
├── macos/
│   ├── defaults.sh
│   └── current-defaults-reference.txt
├── mise/
│   └── config.toml
├── vscode/
│   ├── settings.json
│   ├── keybindings.json
│   ├── mcp.json
│   └── snippets/           ← blade, js, jsx, md, php, svelte, vue, global
├── vscode-insiders/        ← same layout as vscode/
├── zed/
│   ├── settings.json
│   └── themes/
└── zsh/
    ├── .zshenv             ← sourced by ALL zsh (PATH dedupe, machine-aware 1Password)
    ├── .zshrc              ← sources ~/.zsh_aliases and ~/.zsh_secrets
    ├── .zsh_aliases        ← 563 lines of aliases & functions
    └── custom/
        └── themes/
            └── cobalt2.zsh-theme
```

Not in this repo, but referenced by it: `~/.zsh_secrets` (credentials, see
[Secrets](#secrets)) and `~/.zshrc.local` (per-machine overrides, milton only).

### Machine behavior

| | Milton (server) | Peter / Brian (laptops) |
|---|---|---|
| **1Password** | Service account, no Touch ID | Desktop app + Touch ID |
| **API keys** | Auto-loaded at shell startup | `load-secrets` on demand |
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

**This repo is public. Nothing tracked here may contain a credential — including
commented-out ones.** A `#` is not redaction; a commented key is just as readable
to anyone who opens the file on github.com, and `git` keeps it forever once
committed.

### `~/.zsh_secrets`

Credentials live in `~/.zsh_secrets`, which `.zshrc` sources if present:

```bash
[[ -f "$HOME/.zsh_secrets" ]] && source "$HOME/.zsh_secrets"
```

It deliberately sits in `$HOME` rather than in this repo — `$HOME` is not a git
repo, so the file cannot be staged by accident, and no `.gitignore` entry has to
be trusted to hold the line. Keep it at mode `600`:

```bash
chmod 600 ~/.zsh_secrets
```

### Backup and restore

`~/.zsh_secrets` is untracked, so nothing else backs it up. It is stored in
1Password as a document, `zsh secrets (brian)` in the `Brian` vault:

```bash
# restore onto a new machine
op document get "zsh secrets (brian)" --out ~/.zsh_secrets && chmod 600 ~/.zsh_secrets

# verify the stored copy still matches (prints nothing sensitive)
op document get "zsh secrets (brian)" | diff - ~/.zsh_secrets && echo identical

# refresh after rotating a key — the document is a snapshot, not a sync
op document edit "zsh secrets (brian)" ~/.zsh_secrets
```

### Migrating a key to `op read`

The end state is no literal values at all: one 1Password item per credential,
read at shell start, so rotation happens in one place and there is no document
to keep refreshing. `~/.zsh_secrets` carries a commented `op read` block ready
for this. Per key:

```bash
op read "op://Brian/OpenAI API Key/password"   # 1. verify the item resolves first
```

then add the line and delete the literal above it:

```bash
export OPENAI_API_KEY=$(op read "op://Brian/OpenAI API Key/password" 2>/dev/null)
```

Verify before trusting it — `op read` failures are swallowed by `2>/dev/null`
and leave the variable silently empty.

**Requires CLI integration**: 1Password app → Settings → Developer → *Integrate
with 1Password CLI*. Without it, `op` can only authenticate through a shell
session token from `op signin`, which does not carry across shells — so every
new terminal would stall on the `op read` calls.

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
