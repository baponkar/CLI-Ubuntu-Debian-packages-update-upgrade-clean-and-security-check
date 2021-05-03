#---------------------------------------------------------------------------------------------------------------->|
#********Ubuntu Command  Line  Auto Update ,Upgrade and System Check**********  |
#	Author 			 : Bapon Kar                                                                                      |
#	Create Date  : 12/02/2019                                                                                         |
#	Description  :  This is a Command-line bash script.                                            |
#						     This script updating ,upgrading ,Checking any                              |
#						     suspicious activity in your system  and also cleaning.After         |
#               		     completed the job it will send a GUI notification.                         |
# Version         :   1.0.0                                                                                                    |
#	Last Update : 30/08/2020                                                                                          |
#	License : GNU gpl v3.0\                                                                                            |
#	git link : https://github.com/baponkar                                                                    |
#------------------------------------------------------------------------------------------------------------------>|
#!/bin/bash
r="\e[1;31m"                                                            #red color
g="\e[1;32m"                                                            #grreen color
y="\e[1;33m"                                                            #yellow color
b="\e[1;34m"                                                            #blue color
m=="\e[1;35m"                                                           #magenta color
c="\e[1;36m"                                                            #cyan color
w="\e[1;37m"                                                            #white color
u="\e[0m"                                                               #reinstall default color
#-------------------------------------------------------------------------------------------------------->
echo -e "$c--------------------------------------------------------------------------------$u"
echo -e " $y \n\t\t\t\U1F984 Command Line Updater 1.0.0 $u"   
echo -e "$c--------------------------------------------------------------------------------$u"


	
read -p "Please insert SUDO password with enter  : " -s pass  #taking sudo password into pass variable


rkhunter --version
if [[ $? != 0 ]]; then
	echo "You Dont have installed rkhunter package in your system.\nWithout it you cant get security check. "
	read -p "Do you like to install rkhunter  [Y/n]  : " u_op
	if [[ "$u_op" == "y"|| "$u_op"  == "Y" ]]; then
		echo "$pass" | sudo apt -S install rkhunter
	fi
fi 

echo "$pass" | sudo -S apt-get update  #Update packages
echo -e "$g \t\tUpdate completed. $u"
echo "$pass" | sudo -S apt-get upgrade -y  #upgade packages
echo -e "$g \t\tUpgrade completed. $u"                                          
echo "$pass" | sudo -S apt-get dist-upgrade -y  #Distribution upgrade
echo -e "$g \t\tDistribution Upgrade completed. $u"                                          
echo "$pass" | sudo -S apt-get autoclean -y    #cleaning of breaking packges
echo -e "$g \t\tSystem cleaned. $u"                                              
echo "$pass" | sudo -S apt-get autoremove -y  #remove the break packages
echo -e "$g \t\tCorrupted packages removed.$u"    #removing breacked package                                         
echo "$pass" | sudo -S rm -r /home/$USER/.local/share/Trash/files/*>>temp.*
echo -e "$g \t\tTrash Folder Cleaned. $u"                       #clear trash folder
#python3  --version
#if [[ $? -eq 0 ]]; then
#	echo "$pass" | sudo pip3 install --upgrade pip  #Python packages update
#	if [[ $? -eq 0 ]]; then
#		echo "$pass" | sudo pip install --upgrade pip  #Python packages update
#	fi
#fi
#echo -e "$g \t\tPython Packages Updated $u"                                         
echo -e "\n\t\t $g All Updates  & Upgrades are completed.$u" #info message
echo -e "\n\t\t $g Do You like to security  Check  of this System? Type [Y/n] : $u $r\n\t\t\t[Info:It will take  time to complte!]$u"
echo -n "::"
read -n 1 cho  #reading user choice
if [[ $cho == 'y' || $cho == 'Y' ]]
then
	echo "$pass" | sudo -S  rkhunter --sk --propupd 
	echo "$pass" | sudo -S rkhunter --sk -c
	echo -e "The rkhunter security risks.\n"  >> temp
	now=$(date +%d%m%Y%r)
	echo "System last run :$now" >> temp
	cat -n /var/log/rkhunter.log | grep -i warning >> temp
	warning=$(cat temp)
	echo -e "$r $warning $u" 
elif [[ $cho == 'n' || $cho == 'N' ]]
then
	echo -e "$g[ok]$u"
else
	echo -e '$rWrong Option!$u'
fi
echo -e "$c--------------------------------------------------------------------------------$u"
echo -e " $y \n\t\t\t\U1F984 Command Line Updater 1.0.0 $u"        
echo -e "$c--------------------------------------------------------------------------------$u"
echo -e "\n\t\t $r Do You wanna Reebot? Type [Y/n]  : $u"                     #Asking to put a user choice
echo -n "::"
#mplayer /home/uniteworld/github/my_programs/bash_scripts/command_line_updater/reboot_system.mp3
read -n 1 choice        #reading user choice

if [[ $choice == 'y' || $choice == 'Y' ]]
then
	reboot
elif [[ $choice == 'n' || $choice == 'N' ]]
then
	#mplayer /home/uniteworld/github/my_programs/bash_scripts/command_line_updater/thankyou.mp3
	exit
fi
rm temp
rm temp.*
