#!/bin/bash

#This shell script is meant to automate MikrocontollerProjekte's 
#instructions for installing GitLab CE on Raspberry Pi 4 (4GB)

#colors
RED='\e[38;5;196m'        #red
ORANGE='\e[38;5;208m'     #orange

#text manipulation
NT='\e[0m'                #normal text
BOLD='\e[1m'              #bold text
UL='\e[4m'                #underlined text
BLINK='\e[5m'             #blink text

clear                     #clear the screen

#FoxLabPi ASCII Art
echo -e ${ORANGE}"            *.                  *."
echo -e ${ORANGE}"           ***                 ***"
echo -e ${ORANGE}"          *****               *****"
echo -e ${ORANGE}"         .******             *******"
echo -e ${ORANGE}"         ********            ********"
echo -e ${ORANGE}"        ,,,,,,,,,***********,,,,,,,,,"
echo -e ${ORANGE}"       ,,,,,,,,,,,*********,,,,,,,,,,,"
echo -e ${ORANGE}"       .,,,,,,,,,,,*******,,,,,,,,,,,,"
echo -e ${ORANGE}"           ,,,,,,,,,*****,,,,,,,,,."
echo -e ${ORANGE}"              ,,,,,,,****,,,,,,"
echo -e ${ORANGE}"                 .,,,***,,,,"
echo -e ${ORANGE}"                     ,*,."

echo -e ${ORANGE}"    ___           __       _         ${RED}___ _"
echo -e ${ORANGE}"   / __\____  __ / /  __ _| |__     ${RED}/ _ (_)"
echo -e ${ORANGE}"  / _\/ _ \ \/ // /  / _  |  _ \   ${RED}/ /_)/ |"
echo -e ${ORANGE}" / / | (_) >  </ /__| (_| | |_) | ${RED}/ ___/| |"
echo -e ${ORANGE}" \/   \___/_/\_\____/\__,_|_.__/  ${RED}\/    |_|"${NT}

#################
### functions ###
#################

#this will return the user to the menu
pause()
{
    read -p "Press [Enter] to continue down the foxhole..."
}

#this choice will allow the script to update system
updateSystem()
{
    echo "update system packages (optional)"
}

#this choice will allow the script to change hostname and password
hostnameChange()
{
    echo ""
}

