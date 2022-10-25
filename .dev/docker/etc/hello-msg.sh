#!/bin/bash

cNo='\033[0m'       # Text Reset
cBlack='\033[0;30m'        # Black
cRed='\033[0;31m'          # Red
cGreen='\033[0;32m'        # Green
cYellow='\033[0;33m'       # Yellow
cBlue='\033[0;34m'         # Blue
cBlueB='\033[1;34m'        # Blue Bold
cPurple='\033[0;35m'       # Purple
cCyan='\033[0;36m'         # Cyan
cWhite='\033[0;37m'        # White
cGrayL='\033[90m'          # Gray light

cTest='\033[37m'

printf "                   ${cRed} ##       ${cGrayL} .\n"
printf "             ${cRed} ## ## ##      ${cGrayL} ==\n"
printf "           ${cRed}## ## ## ##      ${cGrayL}===\n"
printf "       /\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\\\___/ === ${cNo}${CONTAINER_COPYRIGHT}${cGrayL}\n"
printf "  ${cBlueB}~~~ ${cGrayL}{${cBlueB}~~ ~~~~ ~~~ ~~~~ ~~ ~ ${cGrayL}/  ===- ${cBlueB}~~~${cGrayL}\n"
printf "       \\\______${cWhite} o ${cGrayL}         __/\n"
printf "         \\\    \\\        __/\n"
printf "          \\\____\\\______/${cNo}\n"
printf "\n"
printf "Current datetime: ${cGreen}$(date '+%Y-%m-%d %H:%M:%S (%Z)')${cNo}\n"
eval ${CONTAINER_HELLO_TEXT}
printf "\n"
if [ "$(whoami)" == "root" ]; then
  printf "${cRed}Attention you are logged as ROOT!${cNo}\n\n"
else
  printf "You are logged as ${cGreen}$(whoami)${cNo}\n\n"
fi
