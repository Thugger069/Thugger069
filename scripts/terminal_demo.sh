#!/bin/bash

# Clear environment and set display
unset XDG_RUNTIME_DIR
export DISPLAY=:99

# Configure prompt
export PS1="\[\e[38;5;45m\]\u\[\e[0m\]@\[\e[38;5;198m\]gh-ci\[\e[0m\]:\[\e[38;5;46m\]\w\[\e[0m\]\$ "

# Show header
clear
echo -e "\e[1;38;5;45m"
figlet -w 80 -f cyberlarge "THUGGER069" | lolcat
echo -e "\n\e[3;38;5;198m$(date '+%A, %B %d %Y %H:%M:%S %Z')\e[0m"

# System status
echo -e "\n\e[1;38;5;46m🚀 SYSTEM STATUS:\e[0m"
neofetch --ascii_distro arch_small --off --color_blocks off | lolcat

# Demo commands
echo -e "\n\e[1;38;5;198m💻 DEMO SEQUENCE:\e[0m"
sleep 1

echo -e "\n\e[1;32m\$ node -v\e[0m"
node -v | lolcat
sleep 0.5

echo -e "\n\e[1;32m\$ git status\e[0m"
git status | lolcat
sleep 1

echo -e "\n\e[1;36m✅ SYSTEM OPTIMAL - READY FOR DEPLOYMENT\e[0m" | lolcat
sleep 2
