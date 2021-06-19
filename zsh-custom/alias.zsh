# alias c="clear"
alias f="open -a Finder"

# ls: adding colors, verbose listing
# and humanize the file sizes:
# alias ls="ls --color -l -h"
# alias ll="$(brew --prefix coreutils)/libexec/gnubin/ls -ahlF --color --group-directories-first"

# some ls aliases
# alias la="ls -A"
# alias ll="ls -Al"

alias ll="ls -ltr"
function dir() {
    tree -I '.git|node_modules|bower_componenents|.DS_Store' --dirsfirst --filelimit 90 -L ${1:-3} -aC $2
}

# make aliases sudo-able
alias sudo="sudo "


alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
# mkdir: create parent directories:
alias mkdir="mkdir -pv"

# grep: color and show the line
# number for each match:
alias grep="grep -n --color"

alias vm='ssh vagrant@127.0.0.1 -p 2222'

alias debug="node --inspect-brk ./node_modules/jest/bin/jest.js --no-cache --runInBand --watch"
alias sshkey="cat ~/.ssh/id_rsa.pub | pbcopy && echo 'Copied to clipboard.'"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy && echo 'Copied to clipboard.'"
alias please='sudo $(fc -ln -1)'
alias slime="subl"

# To update brew, npm, gem and their installed packages
alias update='brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update --system; sudo gem update'

function muppd () {
    echo -e "\033[100;44m"
    sudo softwareupdate -ia
    brew update
    echo -e "\033[0m"
}

# ping: stop after 5 pings:
alias ping="ping -c 5"
alias ip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias shorten="pushd ~/@vticonsulting/shortener && yarn shorten \"$1\" \"$2\" && popd"

# curl: only display HTTP header:
alias HEAD="curl -I"
# this create a new HEAD command

alias weather="curl -4 http://wttr.in"






alias bsa='browser-sync start --files "**" --server --no-notify'
alias bsap='browser-sync start --proxy "local-dashboard.boosterthon.com" --files "**" --no-notify'




# alias python=python3


function tdm {
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
}


# npm shortcuts that only list top-level modules
alias l="yarn list --depth=0 2>/dev/null"
alias lg="npm list -g --depth=0 2>/dev/null"

# process finding
alias pg="pgrep -lf"


alias jqq="/Users/vtolbert/@victortolbert/code/jqq/jqq.rb"
