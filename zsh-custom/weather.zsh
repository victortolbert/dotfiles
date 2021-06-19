#Weather
alias weather="curl -s wttr.in | sed -n '1,7p'"
alias weather-long="curl -s wttr.in | sed -n '1,38p'"
alias weather-today="curl -s wttr.in | sed -n '1,17p'"
alias weather-tomorrow="curl -s wttr.in | sed -n '1,7p'"
