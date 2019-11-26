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
        echo "[E]xit to main menu"

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

                "[Ee]")

                        exit 0

                ;;

                *)

                        echo "Invalid input!"
                        sleep 3
                        admin_menu

                ;;

        esac


}

# Call Admin menu
admin_menu

# Task create a security menu with the options:
# Show last logged in users:  last -adx |less
# Check the installed packages:  dpkg -l |less
# Check all users and their ID:  cut -d: -f1,3 /etc/passwd
# Return to the main menu
# Exit the program.




