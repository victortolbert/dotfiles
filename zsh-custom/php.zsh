alias composer="COMPOSER_MEMORY_LIMIT=-1 composer"

alias pa="php artisan"
alias mi="php artisan migrate"
alias mmi="php artisan make:migration"
alias mmo="php artisan make:model"
alias mif="php artisan migrate:fresh --seed"
alias kg="php artisan key:generate"
alias t="php artisan tinker"

alias art="php artisan"
# alias bust="php artisan cache:clear; php artisan route:clear; php artisan config:clear; php artisan telescope:clear; php artisan view:clear"
# alias bust="php artisan optimize:clear; php artisan config:clear"
alias fresh="php artisan migrate:fresh --seed"
alias migrate="php artisan migrate"
alias p="phpunit"
# alias pf="phpunit --filter "
alias pf='vendor/bin/phpunit --filter'
alias tinker="php artisan tinker"

bust() {
  php artisan cache:clear
  php artisan config:clear
  php artisan route:clear
  php artisan view:clear
  php artisan debugbar:clear
  php artisan telescope:clear
}

phpv() {
    valet stop
    brew unlink php@5.6 php@7.1 php@7.2 php@7.3 php@7.4 php
    brew link --force --overwrite $1
    brew services start $1
    composer global update
    rm -f ~/.config/valet/valet.sock
    valet install
}

# alias php70="phpv php@7.0"
alias php56="phpv php@5.6"
alias php71="phpv php@7.1"
alias php72="phpv php@7.2"
alias php73="phpv php@7.3"
alias php74="phpv php@7.4"
alias php80="phpv php"

function servephp() {
    php -S 0.0.0.0:${1:-8000}
}
