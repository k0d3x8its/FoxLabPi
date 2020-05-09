#!/bin/bash

#This shell script is meant to automate MikrocontollerProjekte's instructions for installing GitLab CE on Raspberry Pi 4

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
echo -e "\e[38;5;208m         *.                  *."
echo -e "\e[38;5;208m        ***                 ***"
echo -e "\e[38;5;208m       *****               *****"
echo -e "\e[38;5;208m      .******             *******"
echo -e "\e[38;5;208m      ********            ********"
echo -e "\e[38;5;208m     ,,,,,,,,,***********,,,,,,,,,"
echo -e "\e[38;5;208m    ,,,,,,,,,,,*********,,,,,,,,,,,"
echo -e "\e[38;5;208m    .,,,,,,,,,,,*******,,,,,,,,,,,,"
echo -e "\e[38;5;208m        ,,,,,,,,,*****,,,,,,,,,."
echo -e "\e[38;5;208m           ,,,,,,,****,,,,,,"
echo -e "\e[38;5;208m              .,,,***,,,,"
echo -e "\e[38;5;208m                  ,*,."

echo -e "\e[38;5;208m    ___           __       _         \e[38;5;196m___ _"
echo -e "\e[38;5;208m   / __\____  __ / /  __ _| |__     \e[38;5;196m/ _ (_)"
echo -e "\e[38;5;208m  / _\/ _ \ \/ // /  / _  |  _ \   \e[38;5;196m/ /_)/ |"
echo -e "\e[38;5;208m / / | (_) >  </ /__| (_| | |_) | \e[38;5;196m/ ___/| |"
echo -e "\e[38;5;208m \/   \___/_/\_\____/\__,_|_.__/  \e[38;5;196m\/    |_|"

