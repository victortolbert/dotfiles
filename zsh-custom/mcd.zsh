# Make directory and change into it.

function mcd() {
  mkdir -p "$1" && cd "$1";
}

function mkcd () {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}
