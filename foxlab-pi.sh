#!/bin/bash

#This shell script is meant to automate MikrocontollerProjekte's 
#instructions for installing GitLab CE on Raspberry Pi 4 (4GB)

#colors
RED='\e[38;5;196m'        #red
ORANGE='\e[38;5;208m'     #orange
YELLOW='\e[38;5;11m'      #yellow
WHITE='\e[38;5;15m'       #white
PURPLE='\e[35m'           #purple
LITEPURPLE='\e[95m'       #light purple
LITEGREY='\e[37m'         #light grey

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
    read -p $'\e[38;5;208mPress [Enter] to continue down the foxhole...\e[0m'
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

    echo -e ${YELLOW}"Your existing hostname is:" `hostname`${NT}
    sleep 1
    read -p "Type what you want your hostname to be: " userChoice
    sudo hostnamectl set-hostname $userChoice
    sleep 1
    echo -e ${YELLOW}"Hostname set"
    sleep 1
    echo -e "changing /etc/hosts..."${NT}
    sleep 1
    sudo sed -i "s/$userHostname/$userChoice/g" /etc/hosts
    sleep 1
    echo -e ${YELLOW}"Checking status..."${NT}
    sleep 1.5
    
    echo -e ${ORANGE}"#####################################"${NT}
    echo -e ${YELLOW}"    ${BOLD}---+++--- hostname ---+++---"${NT}
    echo -e ${ORANGE}"#####################################"${NT}
    hostnamectl status | grep host*
    echo -e ${ORANGE}"#####################################"${NT}
    echo -e ${YELLOW}"   ${BOLD}---+++--- /etc/hosts ---+++---"${NT}
    echo -e ${ORANGE}"#####################################"${NT}
    < /etc/hosts grep 127*
    
    pause 
    
}

#this choice will allow the script to change the pi user password
piPasswordChange()
{
    passwd
    pause
}

#this choice will guide the customer to the raspi-config menu to enable SSH
enableSSH()
{
    echo -e ${ORANGE}"####################################################"
    echo -e ${RED}" --+++++-- Configure SSH and Localization --+++++--"
    echo -e ${ORANGE}"####################################################"
    sleep 1
    echo -e ${ORANGE}"When the configuration menu opens go to"${NT}
    echo -e ${RED}"5)Interface Options>P2 SSH and enable it"${NT}
    pause
    sudo raspi-config
    pause
}

#this choice will mount usb storage
mountStorage()
{
    local usbUUID=$1

    echo -e ${YELLOW}"Making directory /media/foxlab..."
    sudo mkdir /media/foxlab
    sleep 0.5
    echo -e ${ORANGE}"done"${NT}
    sleep 0.5
    echo -e ${YELLOW}"checking status..."${NT}
    sleep 0.5
    ls /media
    sleep 0.2
    
    echo -e ${YELLOW}"Changing owner of /media/foxlab..."
    sudo chown pi /media/foxlab
    sleep 0.5
    echo -e ${ORANGE}"done"${NT}
    sleep 0.5

    echo -e ${YELLOW}"Formating the USB storage..."
    sudo sudo mkfs.ext4 /dev/sda1
    sleep 0.5
    echo -e ${ORANGE}"done"${NT}
    sleep 0.5

    echo -e ${YELLOW}"Mounting USB storage to /media/foxlab..."
    sudo mount /dev/sda1 /media/foxlab
    sleep 0.5
    echo -e ${ORANGE}"done"${NT}
    sleep 0.5

    echo -e ${YELLOW}"FoxLab needs your help grabbing the USB storage UUID..."${NT}
    sleep 2
    echo -e                      ${ORANGE}"####################################################"
    echo -e ${BLINK}${REDB}${WHITE}${BOLD} "     copy ONLY what is in quotes after UUID=       "${NT}
    echo -e                      ${ORANGE}"####################################################"${NT}
    sleep 3
    sudo blkid /dev/sda1 | awk '{print $2}'
    echo -e ${ORANGE}"####################################################"${NT}

    sleep 0.5
    read -p $'\e[38;5;11mNow insert the UUID here:\e[0m' usbUUID
    sleep 0.5
    echo -e $usbUUID ${YELLOW}"was inserted"${NT}
    sleep 1
    echo -e "Adding UUID to /etc/fstab..."${NT}
    sleep 0.5
    echo "UUID="$usbUUID"  /media/foxlab  ext4  defaults  0  0" | sudo tee -a /etc/fstab
    sleep 1
    echo -e ${ORANGE}"done"${NT}
    sleep 0.5
    echo -e ${YELLOW}"Checking status..."${NT}
    sleep 0.5

    cat /etc/fstab
    echo -e ${ORANGE}"done"${NT}
    pause
}

#this choice will increase STACK size
stackSize()
{
    echo -e ${YELLOW}"Checking RAM and swapsize..."${NT}
    sleep 1
    echo -e ${ORANGE}"####################################################"${NT}
    echo -e ${YELLOW}"  ----++++---- Free Memory & Swapsize ----++++----  "${NT}
    echo -e ${ORANGE}"####################################################"${NT}
    free --mega | awk '{print (NR==1?"Type":""), $1, $2, $3, (NR==1?"":$4)}' | column -t
    echo -e ${ORANGE}"####################################################"${NT}
    pause

    pause
}

#this choice will download GitLab and install
gitLabInstall()
{
    local userIP=$1

    echo -e ${ORANGE}"####################################################"${NT}
    echo -e ${YELLOW}"   ----++++---- Downloading GitLab ----++++----     "${NT}
    echo -e ${ORANGE}"####################################################"${NT}
    sleep 1
    curl -Lo gitlab-ce_12.6.2-ce.0_armhf.deb https://packages.gitlab.com/gitlab/raspberry-pi2/packages/raspbian/stretch/gitlab-ce_12.6.2-ce.0_armhf.deb/download.deb

    echo -e ${ORANGE}"####################################################"${NT}
    echo -e ${YELLOW}"   ----++++---- Installing GitLab ----++++----      "${NT}
    echo -e ${ORANGE}"####################################################"${NT}
    sleep 1
    sudo dpkg -i gitlab-ce_12.6.2-ce.0_armhf.deb
    echo -e ${ORANGE}"####################################################"${NT}
    echo -e ${YELLOW}"  ----++++---- GitLab Configuration ----++++----    "${NT}
    echo -e ${ORANGE}"####################################################"${NT}

    echo -e ${YELLOW}"Checking IP address..."
    sleep 1
    echo -e ${ORANGE}"####################################################"${NT}
    echo -e ${YELLOW}"     ----++++---- Raspberry Pi IP ----++++----      "${NT}
    echo -e ${ORANGE}"####################################################"${NT}
    echo "http://" | hostname -I
    echo -e ${ORANGE}"####################################################"${NT}
    echo -e ${BLINK}${REDB}${WHITE}${BOLD}"  COPY the IP address above with http:// before it  "${NT}
    echo -e ${ORANGE}"####################################################"${NT}
    sleep 1

    read -p $'\e[38;5;11mInsert the IP address here:\e[0m' userIP
    sleep 1
    echo -e $userIP ${YELLOW}"was inserted"${NT}
    sleep 1
    echo -e ${YELLOW}"Adding IP address to /etc/gitlab/gitlab.rb..."${NT}
    sleep 1
    sudo sed -i "s,http://gitlab.example.com,$userIP,g" /etc/gitlab/gitlab.rb
    echo -e ${ORANGE}"done"${NT}
    sleep 1
    echo -e ${YELLOW}"Checking status..."${NT}
    sleep 1
    sudo sed '23!d' /etc/gitlab/gitlab.rb
    echo -e ${ORANGE}"done"${NT}
    sleep 1

    echo -e ${YELLOW}"Changing unicorn worker processes to 2..."
    sleep 1
    sudo sed -i "750 s/.*/unicorn['worker_processes'] = 2/" /etc/gitlab/gitlab.rb
    echo -e ${ORANGE}"done"${NT}
    sleep 1
    echo -e ${YELLOW}"Checking status..."${NT}
    sleep 1
    sudo sed '750!d' /etc/gitlab/gitlab.rb
    echo -e ${ORANGE}"done"${NT}
    sleep 1

    echo -e ${YELLOW}"Changing the amount of concurrency in your Sidekiq process..."
    sleep 1
    sudo sed -i "814 s/.*/sidekiq['concurrency'] = 9/" /etc/gitlab/gitlab.rb
    echo -e ${ORANGE}"done"${NT}
    sleep 1
    echo -e ${YELLOW}"Checking status..."${NT}
    sleep 1
    sudo sed '814!d' /etc/gitlab/gitlab.rb
    echo -e ${ORANGE}"done"${NT}
    sleep 1

    echo -e ${YELLOW}"Changing where GitLab data is stored..."
    sleep 1
    sudo sed -i '438 s,#, ,' /etc/gitlab/gitlab.rb
    sudo sed -i '439 s,#, ,' /etc/gitlab/gitlab.rb
    sudo sed -i '440 s,.*,     "path" => "/media/foxlab/git-data",' /etc/gitlab/gitlab.rb
    sudo sed -i '441 s,#, ,' /etc/gitlab/gitlab.rb
    sudo sed -i '442 s,#, ,' /etc/gitlab/gitlab.rb
    echo -e ${ORANGE}"done"${NT}
    sleep 1
    echo -e ${YELLOW}"Checking status..."${NT}
    sleep 1
    sudo sed '438,442!d' /etc/gitlab/gitlab.rb
    echo -e ${ORANGE}"done"${NT}
    sleep 1

    echo -e ${YELLOW}"If everything above looks good then"
    echo -e ${YELLOW}"continue down the fox hole otherwise"
    echo -e ${YELLOW}"press [CTL+C] to end the program"
    pause
    echo -e ${YELLOW}"Reconfiguring /etc/gitlab/gitlab.rb..."
    sudo gitlab-ctl reconfigure
    echo -e ${ORANGE}"done"${NT}
    pause
}

#this choice will check if gitlab is running
gitLabCheck()
{
    sudo gitlab-ctl status 

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

    echo -e ${PURPLE}"####################################################"
    echo -e "  ${WHITE}----${PURPLE}+++++++${WHITE}---- ${BOLD}${ORANGE}FoxLab ${RED}Pi ${YELLOW}Menu ${NT}${WHITE}----${PURPLE}+++++++${WHITE}----    "
    echo -e ${PURPLE}"####################################################"${NT}
    echo -e ${PURPLE}"1${ORANGE}) ${LITEGREY}Update System ${LITEPURPLE}- - - - - - - - - - -${ORANGE}(${ORANGE}Recommended${ORANGE})"
    echo -e ${PURPLE}"2${ORANGE}) ${LITEGREY}Change Pi Password ${LITEPURPLE}- - - - - - - - ${ORANGE}(${ORANGE}Recommended${ORANGE})"
    echo -e ${PURPLE}"3${ORANGE}) ${LITEGREY}Change Hostname ${LITEPURPLE}- - - - - - - - - -${ORANGE}(${ORANGE}Recommended${ORANGE})"
    echo -e ${PURPLE}"4${ORANGE}) ${LITEGREY}Enable SSH ${LITEPURPLE}- - - - - - - - - - - - ${ORANGE}(${YELLOW}Optional${ORANGE})"
    echo -e ${PURPLE}"5${ORANGE}) ${LITEGREY}Mount USB Storage ${LITEPURPLE}- - - - - - - - -${ORANGE}(${ORANGE}Recommended${ORANGE})"
    echo -e ${PURPLE}"6${ORANGE}) ${LITEGREY}Increase STACK size ${LITEPURPLE}- - - - - - - -${ORANGE}(${ORANGE}Recommended${ORANGE})"
    echo -e ${PURPLE}"7${ORANGE}) ${LITEGREY}Download & install GitLab ${LITEPURPLE}- - - - -${ORANGE}(${RED}Necessary${ORANGE})"
    echo -e ${PURPLE}"8${ORANGE}) ${LITEGREY}Check that GitLab is running ${LITEPURPLE}- - - ${ORANGE}(${YELLOW}Optional${ORANGE})"
    echo -e ${PURPLE}"9${ORANGE}) ${LITEGREY}Exit"
}

#this will read the users input
readOptions()
{
    local userChoice
    read -p $'\e[38;5;208mWhich foxhole do you want to tumble down...\e[0m' userChoice
    case $userChoice in
        1) updateSystem ;;
        2) piPasswordChange ;;
        3) hostnameChange ;;
        4) enableSSH ;;
        5) mountStorage ;;
        6) stackSize ;;
        7) gitLabInstall ;;
        8) gitLabCheck ;;
        9) exit 0 ;;
        *) echo -e ${BLINK}${REDB}${WHITE}"WARNING${NT}${ORANGE}...You have traveled down the wrong foxhole"${NT} && sleep 4 ;;
    esac
}

while true
do
    foxLabMenu
    readOptions
done