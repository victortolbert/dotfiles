# Machine Rebuild — Open Items

**Machine:** `brian` (primary dev MacBook) · **Audited:** 2026-08-09

Generated from a live audit of `$PATH`, `Brewfile`, `mise`, and installed tooling.
Every item below was verified against the actual machine — nothing here is guesswork
from reading config alone.

> **How to re-run this audit** — see [Appendix](#appendix-re-running-the-audit) at the bottom.

---

## 1. Dead `$PATH` entries — decide: reinstall or remove

These are in `zsh/.zshrc` and point at directories that don't exist. A missing PATH
entry is skipped silently, so **none of these are breaking anything** — they're a
to-do list of things not yet reinstalled, plus a few that are genuinely vestigial.

Line numbers are current as of this audit.

| Line | Path | What owns it | Verdict |
|---|---|---|---|
| 243 | `~/.bin` | — | ❌ **Remove.** `install.sh` links `bin/*` into `~/.local/bin`, not `~/.bin`. Nothing populates this. Vestigial. |
| 203–204 | `~/.jenv/bin` + `eval "$(jenv init -)"` | jenv | ⚠️ **Probably remove.** jenv is installed via Homebrew (so the `eval` works), but **mise already manages Java 21** per `mise/config.toml`. Two version managers on the same runtime is a conflict waiting to happen. Pick mise. |
| 193 | `/opt/homebrew/opt/dotnet@8/bin` | .NET 8 | 🔁 **Reinstall or remove.** Not installed. `brew install dotnet@8` if you still need it. |
| 118 | `~/.dotnet/tools` | .NET global tools | 🔁 Same call as above — pairs with `dotnet@8`. |
| 117 | `~/.composer/vendor/bin` | Composer globals | 🔁 **Likely reinstall.** Herd is installed and on PATH, so PHP work is live; the Composer global bin dir just hasn't been recreated. |
| 175 | `~/.codeium/windsurf/bin` | Windsurf | ❌ **Remove** unless you plan to reinstall Windsurf. Not present, and you're not using it. |
| 256 | `~/.lmstudio/bin` | LM Studio | 🔁 **Your call.** Reinstall if you still want local models; otherwise remove. |
| — | `/usr/ucb` | macOS | ✅ **Ignore.** Ancient BSD compat path in the system default; not yours. |

### Not actually a problem

While auditing, `node/24.16.0/bin` appeared to still be in `$PATH` after being removed
from `.zshrc`. It isn't. That was **PATH inheritance** — Claude Code terminals inherit an
already-built `PATH` and then re-run `.zshrc`, which is exactly what the comment in
`zsh/.zshenv` warns about. A clean-environment shell confirms it's gone.

**Lesson for future audits:** test PATH changes with a clean env, not an inherited one:

```bash
env -i HOME="$HOME" USER="$USER" SHELL=/bin/zsh TERM=xterm /bin/zsh -i -c \
  'for d in ${(s/:/)PATH}; do [ -d "$d" ] || echo "DEAD: $d"; done'
```

---

## 2. Homebrew drift

**The Brewfile is essentially satisfied.** `brew bundle check` reports failures, but every
one is naming drift or staleness, not a missing package. Verified individually:

| `brew bundle` says | Reality |
|---|---|
| `openssl` missing | Installed as `openssl@3` |
| `python` missing | Installed as `python@3.x` |
| Cask `docker` missing | Renamed upstream to `docker-desktop` — installed, `Docker.app` present |
| Cask `tailscale` missing | Renamed upstream to `tailscale-app` — installed |
| `google-chrome`, `firefox`, `stats` | All present in `/Applications`; just **outdated** |
| `node`, `pnpm`, `deno` | Present; `node` comes from Vite+, not brew |

### To-do

- [ ] **Update `Brewfile` for the renames** so `brew bundle` stops erroring:
      `docker` → `docker-desktop`, `tailscale` → `tailscale-app`.
- [ ] **Upgrade outdated packages** — 8 formulae (`deno`, `fontconfig`, `libffi`, `mise`,
      `node`, `pnpm`, `sdl3`, `usage`) and 5 casks (`firefox`, `google-chrome`, `stats`,
      `visual-studio-code`, `zed`).
- [ ] Decide whether `Brewfile.bak` is still needed or can be deleted.

---

## 3. Tooling not yet reinstalled

Present and working: `brew git node npm pnpm bun deno python3 java docker gh op code zed
tmux fzf rg jq starship mise pi codex claude railway vercel netlify`.

Missing — flagged by likelihood you actually want them back:

| Tool | Assessment |
|---|---|
| **`uv`** | ⚠️ **Likely wanted.** Your README says `.zsh_aliases` includes Python/uv aliases — so those aliases are currently dead. `brew install uv` |
| `nvim` | Probable, if you use it. `brew install neovim` |
| `direnv` | Probable, common in this kind of setup. |
| `supabase` | Only if you have active Supabase projects. |
| `go`, `rustc`/`cargo` | Only if you're doing Go/Rust work — no evidence in your configs. |
| `pyenv`, `rbenv` | ❌ **Skip.** mise already handles Ruby 3.3.6; adding these repeats the jenv mistake. |

---

## 4. Config issues worth fixing

- [ ] **Pi installer appends, never replaces.** Each Vite+ runtime upgrade adds a new
      `# Pi` PATH block instead of updating the old one. This already produced a duplicate
      (`24.16.0` + `24.19.0`) — cleaned up on 2026-08-09. **Expect it to recur on the next
      Pi upgrade**; just delete the stale block when it does.
- [ ] **Installer-appended blocks are accumulating in `zsh/.zshrc`.** Google Cloud SDK,
      Railway, Pi, and Herd have all appended to the end of the file. Herd appears
      **twice** (lines 134 and 274). Consider consolidating into a managed section.
- [ ] **Absolute paths from installers.** Installers hardcode `/Users/victortolbert/...`,
      which breaks portability across your three machines (`milton`, `peter`, `brian`).
      The gcloud and Pi lines were converted to `$HOME` on 2026-08-09 — worth doing to the
      rest.
- [ ] **`zsh/.zshrc` is uncommitted** in the dotfiles repo, carrying this session's changes
      plus earlier installer additions from Pi and Railway.

---

## 5. Cloud & AI subscriptions

From the 2026-08-09 subscription review. Full rationale in the memory note
`ai-subscription-split.md`.

- [ ] **Downgrade Google AI Ultra → AI Pro** at [one.google.com/settings](https://one.google.com/settings).
      Storage is a non-issue (331.61 GB used of 30 TB; AI Pro includes 5 TB).
      *If billed via the App Store, cancel at [apps.apple.com/account/subscriptions](https://apps.apple.com/account/subscriptions) instead.*
- [ ] **Set a budget alert** on the Gemini billing account — currently **none**, and the
      Budget API isn't even enabled.
      [console.cloud.google.com/billing/01C7A4-F7B183-ED4F11/budgets](https://console.cloud.google.com/billing/01C7A4-F7B183-ED4F11/budgets)
- [ ] **Audit 3 live Gemini API keys** in project `gen-lang-client-0869378698`:
      - `Gemini API Key (Brian)` (Apr 2026) — **in use**, referenced by `~/.pi/web-search.json` via `op://Brian/Google Gemini API Key`
      - `UXLab Dev` (Feb 2026) — purpose unclear
      - `Generative Language API Key` (Mar 2025) — 17 months old, likely stale

      > Given the AWS account compromise via a leaked key, standing unaudited credentials
      > deserve the same treatment. Rotate or delete what isn't in use.
- [ ] **Install Antigravity** ([antigravity.google](https://antigravity.google)) if you want
      any coding value from the Google subscription. It is the *only* path — Google's
      consumer AI subscriptions cannot be used by third-party agents like pi, which is why
      pi's Gemini access is metered API-key billing regardless of tier.

### Already done

- ✅ Cancelled Cursor ($20/mo — was never installed on this machine)
- ✅ Rebalanced `~/.pi/agent/settings.json` onto Claude Max; reviewer deliberately left on
      `openai-codex/gpt-5.5` for independent review
- ✅ Moved `google-cloud-sdk` out of `~/Downloads` → `~/google-cloud-sdk`

---

## 6. Cleanup

Backups created 2026-08-09, safe to delete once you're satisfied:

- `~/.zshrc.bak-20260809`
- `~/.pi/agent/settings.json.bak-20260809`

Also on the Gemini billing account: project `milton-490101` is billing-enabled. Confirm
that's intentional — it shares the billing account with the Gemini API project.

---

## Appendix: re-running the audit

```bash
# Dead PATH entries (clean env — avoids inherited-PATH false positives)
env -i HOME="$HOME" USER="$USER" SHELL=/bin/zsh TERM=xterm /bin/zsh -i -c \
  'for d in ${(s/:/)PATH}; do [ -d "$d" ] || echo "DEAD: $d"; done'

# Brewfile drift
cd ~/Projects/dotfiles && brew bundle check --file=Brewfile --verbose
brew outdated --formula && brew outdated --cask

# Tool presence sweep
for t in uv nvim direnv go rustc supabase; do
  printf '%-10s %s\n' "$t" "$(command -v $t 2>/dev/null || echo '-- MISSING')"
done
```
