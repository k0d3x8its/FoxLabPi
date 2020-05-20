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

#this choice will allow the script to change hostname
hostnameChange()
{
    local userChoice=$1
    local userHostname=$(hostname)

    echo "Your existing hostname is:" `hostname`
    sleep 1
    read -p "Type what you want your hostname to be: " userChoice
    sudo hostnamectl set-hostname $userChoice
    sleep 1
    echo "Hostname set"
    sleep 1
    echo "changing /etc/hosts..."
    sleep 1
    sudo sed -i "s/$userHostname/$userChoice/g" /etc/hosts
    sleep 1
    echo "Checking status..."
    sleep 1.5
    
    echo -e ${ORANGE}"#####################################"
    echo -e ${ORNAGE}"    ${BOLD}---+++--- hostname ---+++---"${NT}
    echo -e ${ORANGE}"#####################################"${NT}
    hostnamectl status | grep host*
    echo -e ${ORANGE}"#####################################"
    echo -e ${ORNAGE}"   ${BOLD}---+++--- /etc/hosts ---+++---"${NT}
    echo -e ${ORANGE}"#####################################"${NT}
    cat /etc/hosts | grep 127*
    
    pause 
    
}

#this choice will allow the script to change the pi user password
piPasswordChange()
{
    passwd
    pause
}

#this choice will enable SSH by creating an ssh doc in /boot directory
enableSSH()
{
    echo "Enable SSH"
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
    echo -e ${ORANGE}"               *.                  *."
    echo -e ${ORANGE}"              ***                 ***"
    echo -e ${ORANGE}"             *****               *****"
    echo -e ${ORANGE}"            .******             *******"
    echo -e ${ORANGE}"            ********            ********"
    echo -e ${ORANGE}"           ,,,,,,,,,***********,,,,,,,,,"
    echo -e ${ORANGE}"          ,,,,,,,,,,,*********,,,,,,,,,,,"
    echo -e ${ORANGE}"          .,,,,,,,,,,,*******,,,,,,,,,,,,"
    echo -e ${ORANGE}"              ,,,,,,,,,*****,,,,,,,,,."
    echo -e ${ORANGE}"                 ,,,,,,,****,,,,,,"
    echo -e ${ORANGE}"                    .,,,***,,,,"
    echo -e ${ORANGE}"                        ,*,."

    echo -e ${ORANGE}"       ___           __       _         ${RED}___ _"
    echo -e ${ORANGE}"      / __\____  __ / /  __ _| |__     ${RED}/ _ (_)"
    echo -e ${ORANGE}"     / _\/ _ \ \/ // /  / _  |  _ \   ${RED}/ /_)/ |"
    echo -e ${ORANGE}"    / / | (_) >  </ /__| (_| | |_) | ${RED}/ ___/| |"
    echo -e ${ORANGE}"    \/   \___/_/\_\____/\__,_|_.__/  ${RED}\/    |_|"${NT}

    echo "####################################################"
    echo "  ----+++++++---- FoxLab Pi Menu ----+++++++----    "
    echo "####################################################"
    echo "1) Update System - - - - - - - - - - -(optional)"
    echo "2) Change Hostname - - - - - - - - - -(Optional)"
    echo "3) Change Pi password - - - - - - - - (Recommended)"
    echo "4) Enable SSH - - - - - - - - - - - - (Optional)"
    echo "5) Mount USB Storage - - - - - - - - -(Recommended)"
    echo "6) Increase STACK size - - - - - - - -(Recommended)"
    echo "7) Download & install GitLab - - - - -(Necessary)"
    echo "8) Check that GitLab is running - - - (Optional)"
    echo "9) Exit"
}

#this will read the users input
readOptions()
{
    local userChoice
    read -p "Which foxhole do you want to tumble down..." userChoice
    case $userChoice in
        1) updateSystem ;;
        2) hostnameChange ;;
        3) piPasswordChange ;;
        4) enableSSH ;;
        5) mountStorage ;;
        6) stackSize ;;
        7) gitLabInstall ;;
        8) gitLabCheck ;;
        9) exit 0 ;;
        *) echo -e ${BLINK}${REDB}${WHITE}"WARNING${NT}${ORANGE}...You have traveled down the wrong foxhole"${NT} && sleep 3 ;;
    esac
}

while true
do
    foxLabMenu
    readOptions
done
