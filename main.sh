set -o vi
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/includes.sh"
source "$DIR/aliases.sh"
source "$DIR/hist.sh"

PS1='\[\033[37;1m\]\u\[\033[0m\]@\[\033[31;1m\]\H\[\033[0m\] \[\033[90;1m\](\D{%l:%m:%S %P} )\[\033[0m\] \[\033[34m\]\w\[\033[39m\] $: '
#PS1="\033[37;1m\u\033[0m@\033[31;1m\H\033[0m \033[90;1m(\D{%l:%m:%S %P} )\033[0m \033[34m\w\033[39m \$: "

neofetch

