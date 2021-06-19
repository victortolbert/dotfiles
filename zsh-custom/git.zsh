alias init="git init && git add . && git commit -m '✨ init'"
alias nah='git reset --hard; git clean -df'
alias wip="git add . && git commit -m 'wip'"
alias git='hub'

alias gl='git lg --reverse'
alias lg='git lg --reverse'

alias s='git status'
alias gs='git status'
# alias status='git status'

alias a.="git add ."
alias ga='git add'
# alias a="git add"
# alias add='git add'

alias gc='git commit'
# alias commit='git commit'


alias gm='git merge'
alias gmerge='git merge'
# alias merge='git merge'

alias gb='git branch'
alias branch='git branch'
alias gbranch='git branch'

alias co='git checkout'
alias gco='git checkout'
alias checkout='git checkout'
alias develop='git checkout develop'
alias staging='git checkout staging'
alias master='git checkout master'

alias gbd='git branch -d'

alias gra='git remote add'
alias grr='git remote rm'
alias grv='git remote -v'

alias gfetch='git fetch'

alias pul='git pull'
alias gpull='git pull'
# alias pull='git pull'

alias gpush='git push'
alias gpod='git push -u origin develop'
alias gpom='git push -u origin master'
# alias push='git push'

alias gstash='git stash'
# alias stash='git stash'

alias gfix='git diff --name-only | uniq | xargs code'

# No arguments: `git status`
# With arguments: acts like `git`
# g() {
#   if [[ $# -gt 0 ]]; then
#     git "$@"
#   else
#     git status
#   fi
# }



function hosts {
  cat ~/.ssh/config | grep "Host "
}


function epic() {
  git pull;
  git checkout -b $1;
  git push origin head -u;
  cd common;
  git pull;
  git checkout -b $1;
  git push origin head -u;
  cd ..;
  if [ $# -gt 1 ]
    then
      git checkout -b "$1_$2";
      cd common;
      git checkout -b "$1_$2";
      cd ..;
  fi
}

function c {
  if [ -d common ]; then
    cd common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout $1
    cd ..
  fi

  if [ -d docs ]; then
    cd docs
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout $1
    cd ..
  fi

  if [ -d solid-doodle ]; then
    cd solid-doodle
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout $1
    cd ..
  fi

  if [ -d super-fiesta ]; then
    cd super-fiesta
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout $1
    cd ..
  fi

  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git checkout $1
}

function cb {
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git checkout -b $1

  if [ -d common ]; then
    cd common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout -b $1
    cd ..
  fi

  if [ -d docs ]; then
    cd docs
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout -b $1
    cd ..
  fi

  if [ -d solid-doodle ]; then
    cd solid-doodle
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout -b $1
    cd ..
  fi

  if [ -d super-fiesta ]; then
    cd super-fiesta
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout -b $1
    cd ..
  fi
}

function commit {
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git commit -am $1
  if [ -d common ]; then
    cd common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git commit -am $1
    cd..
  fi

  if [ -d docs ]; then
    cd docs
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git commit -am $1
    cd..
  fi

  if [ -d solid-doodle ]; then
    cd solid-doodle
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git commit -am $1
    cd..
  fi

  if [ -d super-fiesta ]; then
    cd super-fiesta
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git commit -am $1
    cd..
  fi
}

function add {
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git add . --all

  if [ -d common ]; then
    cd common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git add . --all
    cd ..
  fi

  if [ -d docs ]; then
    cd docs
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git add . --all
    cd ..
  fi

  if [ -d solid-doodle ]; then
    cd solid-doodle
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git add . --all
    cd ..
  fi

  if [ -d super-fiesta ]; then
    cd super-fiesta
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git add . --all
    cd ..
  fi
}

function stash {
  if [ -d common ]; then
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    cd common
    git stash $1
    cd ..
  fi

  if [ -d docs ]; then
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    cd docs
    git stash $1
    cd ..
  fi

  if [ -d solid-doodle ]; then
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    cd solid-doodle
    git stash $1
    cd ..
  fi

  if [ -d super-fiesta ]; then
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    cd super-fiesta
    git stash $1
    cd ..
  fi

  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git stash $1
}

function status {
  if [ -d common ]; then
    cd common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git status
    cd ..
  fi

  if [ -d docs ]; then
    cd docs
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git status
    cd ..
  fi

  if [ -d solid-doodle ]; then
    cd solid-doodle
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git status
    cd ..
  fi

  if [ -d super-fiesta ]; then
    cd super-fiesta
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git status
    cd ..
  fi

  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git status
}
function pull {
  if [ -d common ]; then
    cd common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git pull origin $1
    cd ..
  fi

  if [ -d docs ]; then
    cd docs
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git pull origin $1
    cd ..
  fi

  if [ -d solid-doodle ]; then
    cd solid-doodle
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git pull origin $1
    cd ..
  fi

  if [ -d super-fiesta ]; then
    cd super-fiesta
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git pull origin $1
    cd ..
  fi

  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git pull origin $1
}

function push {
  if [ -d common ]; then
    cd common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git push -u origin HEAD
    cd ..
  fi

  if [ -d docs ]; then
    cd docs
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git push -u origin HEAD
    cd ..
  fi

  if [ -d solid-doodle ]; then
    cd solid-doodle
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git push -u origin HEAD
    cd ..
  fi

  if [ -d super-fiesta ]; then
    cd super-fiesta
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git push -u origin HEAD
    cd ..
  fi

  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git push -u origin HEAD
}

function merge {
  if [ -d common ]; then
    cd common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git merge $1
    cd ..
  fi

  if [ -d docs ]; then
    cd docs
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git merge $1
    cd ..
  fi

  if [ -d solid-doodle ]; then
    cd solid-doodle
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git merge $1
    cd ..
  fi

  if [ -d super-fiesta ]; then
    cd super-fiesta
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git merge $1
    cd ..
  fi

  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git merge $1
}


# git shortcuts
# alias gs="git status"
# alias ga="git add -A ."
# alias gc="git commit"
# alias gb="git branch"
# alias gd="git diff"
# alias gco="git checkout"
# alias gp="git push"
# alias gl="git pull"
# alias gt="git tag"
# alias gm="git merge"
# alias gg="git log --graph --pretty=format:'%C(bold red)%h%Creset -%C(bold yellow)%d%Creset %s %C(bold green)(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# alias gcp="git cherry-pick"
# alias gbg="git bisect good"
# alias gbb="git bisect bad"
