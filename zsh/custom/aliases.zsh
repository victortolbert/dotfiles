# ─── General ─────────────────────────────────────────────────
alias f="open -a Finder"
alias ll="ls -ltr"
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir="mkdir -pv"
alias grep="grep -n --color"
alias please='sudo $(fc -ln -1)'
alias sshkey="cat ~/.ssh/id_rsa.pub | pbcopy && echo 'Copied to clipboard.'"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy && echo 'Copied to clipboard.'"

# ─── Git ─────────────────────────────────────────────────────
alias tg='git'
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gcm='git commit -m'

# ─── Modern CLI replacements ─────────────────────────────────
# Uncomment if installed:
# alias cat='bat'
# alias ls='eza'

# ─── Dev ─────────────────────────────────────────────────────
alias dev='pnpm dev'
alias build='pnpm run build'
alias tc='pnpm run typecheck'
alias lint='pnpm run lint:fix'

# ─── Tree / Dir ──────────────────────────────────────────────
function dir() {
    tree -I '.git|node_modules|.nuxt|.output|.DS_Store' --dirsfirst --filelimit 90 -L ${1:-3} -aC $2
}
