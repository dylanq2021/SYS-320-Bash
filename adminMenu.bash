#!/bin/bash

# Admin and Security admin menu.
function main_menu() {

        # Clear the screen
        clear

        echo "1. System Admin Menu"
        echo "2. Security Admin Menu"
        echo "[E]xit"

        echo -n "Please select with menu you want to use: "
        read menuOption

        if [[ ${menuOption} -eq 1 ]]
        then

                admin_menu

        elif [[ ${menuOption} -eq 2 ]]
        then

                security_menu

        else

                exit 0

        fi

}


# Admin menu
function admin_menu() {

        # Clear the screen
        clear

        # Create menu options
        echo "1. List Running Processes"
        echo "2. Show Open Network Sockets"
        echo "3. Check logged in Users"
	echo "4. Check uptime, runlevel of proceses"
	echo "5. Check version of GCC"
	echo "6. Check MySQL version"
	echo "7. Check mounted File Share"
	echo "8. Check last logged in user"
        echo "9. Exit to main menu"

        # Prompt for the menu option
        echo -n "Please enter a value above. "
        read option

        # process the options
        case ${option} in

                1)
                        ps -ef |less
                ;;

                2)
                        # List ALL open network sockets
                        netstat -an --inet |less
                        # lsof -i -n |less
                ;;

                3)
                        # Show logged in user details
                        w |less
                ;;

                4)
                        # Check running proceses, helps a sysadmin know whats going on within the network
                        who -a |less
                ;;

                5)
                        #Check GCC Version , helps a sysadmin compile processes
                        gcc -v |less
                ;;

                6)
                        # Check MySQl Version, allows a sysadmin to ensure  MySQL is up to date which helps with security
                        mysql --version |less
                ;;

                7)
                        # Check mounted file share information, helps a sysadmin ensure disk space is free and not full
                        df -k |less
                ;;

                8)
                        # Show last logged on user, helps a sysadmin identify who was recently on the network, can help identify who could have caused a problem
                        last -a |less
                ;;

                9)
                        main_menu
                ;;

                *)
                        echo "Invalid input!"
                        sleep 3
                        admin_menu
                ;;

        esac
}

# Task create a security menu with the options:
# Show last logged in users:  last -adx |less
# Check the installed packages:  dpkg -l |less
# Check all users and their ID:  cut -d: -f1,3 /etc/passwd
# Return to the main menu
# Exit the program.

# Security menu
function security_menu() {

        # Clear the screen
        clear

        # Create menu options
        echo "1. Show loast logged in users"
        echo "2. Check install packages"
        echo "3. Check all users and their ID"
	echo "4. Access Incident Response Menu"
        echo "5. Exit to main menu"

        # Prompt for the menu option
        echo -n "Please enter a value above. "
        read option

        # process the options
        case ${option} in

                1)
                        last -adx |less
                ;;

                2)
                        # Check installed packages
                        dpkg -l |less
                ;;

                3)
                        # Check allusers and ID
                        cut -d: -f1,3 /etc/passwd |less
                ;;

		4)
			# Call Incident Response Menu
			incident_menu
		;;

                5)
                        main_menu
                ;;

                *)
                        echo "Invalid input!"
                        sleep 3
                        security_menu
                ;;

	esac
}
function incident_menu() {

        # Clear the screen
        clear

        # Create menu options
        echo "1. Check Root Logins "
        echo "2. Check Authorized SSH Keys"
        echo "3. Check Known SSH Hosts"
        echo "4. Check Scheduled Jobs"
        echo "5. View Sudoers List"
	echo "6. Check Command History"
	echo "7. View Encrypted Passwords File"
	echo "8. Check MySQL History"
	echo "9. View Logged in Users"
	echo "10. List Open Files"
	echo "11. Return to Security Admin Menu"
	echo "12. Return to Main Menu"

        # Prompt for the menu option
        echo -n "Please enter a value above. "
        read option

        # process the options
        case ${option} in

                1)
			# Very usefl to know if the Root account was recently accessed to run high level commands
                        ls -alh /root/ |less
                ;;

                2)
                        # Check installed packages to ensure nothing is installed that shouldn't be
                        cat /home/*/.ssh/authorized_keys |less
                ;;

                3)
                        # Check allusers and ID to ensure everyone in the network is accounted for and there are no extraneous users or old accounts active
                        cat /home/*/.ssh/known_hosts |less
                ;;

                4)
                        # See if any scheduled tasks are assigned that shouldn't be, could revela that someone setup a task that could be harmful indicating a breach
                        cat /var/spool/cron/crontabs/* |less
                ;;

                5)
			# Check who has sudo priviledges and if that account was recently accessed to invoke a high level command
                        cat /etc/sudoers |less
                ;;

		6)
			# Check to see what commands were recently run if the network is acting strange
			tail -n 100 ~./bash_history |more |less
		;;

		7)
			# See when an account was recently changed which could indicate an account was recently compromised
			cat /etc/shadow |less
		;;

		8)
			# Check if MySQL had any queries that were malicious in intent and what was attempted
			cat /home/*/.mysql_history |less
		;;

		9)
			# View Which users are logged in to ensure no malicious or suspicious accounts are active
			w |less
		;;

		10)
			# Check if the network drives are containing large files that could cause harm and how much of a drive is being used
			lsof -nPi |less
		;;

		11)
			security_menu
		;;

		12)
			main_menu
		;;

                *)
                        echo "Invalid input!"
                        sleep 3
                        incident_menu
                ;;

        esac
}
main_menu
