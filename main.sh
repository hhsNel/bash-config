DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/includes.sh"
source "$DIR/aliases.sh"
source "$DIR/hist.sh"

PS1="\033[37m\u\033[39m@\033[31m\H\033[39m \033[90m(\D{%l:%m:%S %P})\033[39m $"

neofetch

