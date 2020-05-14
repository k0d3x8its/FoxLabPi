#!/bin/bash

#This shell script is meant to automate MikrocontollerProjekte's 
#instructions for installing GitLab CE on Raspberry Pi 4 (4GB)

#colors
RED='\e[38;5;196m'        #red
ORANGE='\e[38;5;208m'     #orange
YELLOW='\e[38;5;93m'      #yellow
WHITE='\e[38;5;15m'       #white

#Background colors
REDB='\e[41m'             #red

#text manipulation
NT='\e[0m'                #normal text
BOLD='\e[1m'              #bold text
UL='\e[4m'                #underlined text
BLINK='\e[5m'             #blink text


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
    sudo apt update && sudo apt upgrade

    pause 
}

#this choice will allow the script to change hostname and password
hostnameChange()
{
    echo "Hostname Change"

    pause
}

#this choice will mount usb storage
mountStorage()
{
    echo "Mount Storage"

    pause
}

#this choice will increase STACK size
stackSize()
{
    echo STACK Size

    pause
}

#this choice will download GitLab and install
gitLabInstall()
{
    echo "GitLab Download and Install"

    pause
}

#this choice will check if gitlab is running
gitLabCheck()
{
    echo "GitLab Check"

    pause
}


#this will display the choices in a menu format
foxLabMenu()
{
    clear                     

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

    echo "####################################################"
    echo "  ----+++++++---- FoxLab Pi Menu ----+++++++----    "
    echo "####################################################"
    echo "1) Update System - - - - - - - - - - -(optional)"
    echo "2) Change Hostname & Password - - - - (Optional)"
    echo "3) Mount USB Storage - - - - - - - - -(Recommended)"
    echo "4) Increase STACK size - - - - - - - -(Recommended)"
    echo "5) Download & install GitLab - - - - -(Necessary)"
    echo "6) Check that GitLab is running - - - (Optional)"
    echo "7) Exit"
}

#this will read the users input
readOptions()
{
    local userChoice
    read -p "Which foxhole do you want to tumble down..." userChoice
    case $userChoice in
        1) updateSystem ;;
        2) hostnameChange ;;
        3) mountStorage ;;
        4) stackSize ;;
        5) gitLabInstall ;;
        6) gitLabCheck ;;
        7) exit 0 ;;
        *) echo -e "${BLINK}${REDB}${WHITE}WARNING${NT}${ORANGE}...You have traveled down the wrong foxhole"${NT} && sleep 6
    esac
}

while true
do
    foxLabMenu
    readOptions
done
