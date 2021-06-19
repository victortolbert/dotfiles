alias up="homestead up && trapperkeeper up"
alias down="trapperkeeper halt && homestead halt"

function trapperkeeper() {
    ( cd ~/@booster/code/TrapperKeeper && vagrant $* )
}

function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

# create epic branches for folder and titan common
function gitepic() {
  git pull;
  git checkout -b $1;
  git push origin head -u;
  cd titan-common;
  git pull;suer
  git checkout -b $1;
  git push origin head -u;
  cd ..;
  if [ $# -gt 1 ]
    then
      git checkout -b "$1_$2";
      cd titan-common;
      git checkout -b "$1_$2";
      cd ..;
  fi
}

function gitc {
  if [ -d titan-common ]; then
    cd titan-common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout $1
    cd ..
  fi
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git checkout $1
}

function gitcb {
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git checkout -b $1
  if [ -d titan-common ]; then
    cd titan-common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git checkout -b $1
    cd ..
  fi
}

function gitcommit {
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git commit -am $1
  if [ -d titan-common ]; then
    cd titan-common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git commit -am $1
    cd..
  fi
}

function gitadd {
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git add . --all
  if [ -d titan-common ]; then
    cd titan-common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git add . --all
    cd ..
  fi
}

function gitstash {
  if [ -d titan-common ]; then
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    cd titan-common
    git stash $1
    cd ..
  fi
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git stash $1
}

function gitstatus {
  if [ -d titan-common ]; then
    cd titan-common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git status
    cd ..
  fi
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git status
}
function gitpull {
  if [ -d titan-common ]; then
    cd titan-common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git pull origin $1
    cd ..
  fi
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git pull origin $1
}

function gitpush {
  if [ -d titan-common ]; then
    cd titan-common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git push -u origin HEAD
    cd ..
  fi
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git push -u origin HEAD
}

function gitmerge {
  if [ -d titan-common ]; then
    cd titan-common
    echo -e "\e[0;32m${PWD##*/}\e[0m"
    git merge $1
    cd ..
  fi
  echo -e "\e[0;32m${PWD##*/}\e[0m"
  git merge $1
}
