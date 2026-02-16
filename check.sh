#!/usr/bin/env bash

clear
opt=0

while [[ $opt -ne 99 ]]; do
	echo ""
	echo "Welcome to the Find The Keys checker!"
	echo "If this is your first time here, I'd highly recommend that you read the instructions."
	echo ""
	echo "What would you like to do?"
	echo "1) Read instructions"
	echo "2) Check an answer"
	echo "3) See all badges"
	echo ""
	echo "99) Exit"
	echo ""

	read -r opt

	if [[ $opt -eq 1 ]]; then
		clear
		echo ""
		echo "Welcome to Find The Keys, a CTF/Find the object inspired game!"
		echo "To play this game, it is recommended to use a Linux operating system for the best play."
		echo "If you are on a Linux distribution, this game is also best played in it's command line."
		echo ""
		echo ""
		echo "--- The Rules---"
		echo ""
		echo "Hidden within this directory are many differernt keys, each formatted in the same way:"
		echo "\"key{the_solution}\""
		echo "Once you find one of these, copy the entire key (the \"key\" plaintext before the bracket, the open bracket, the phrase in the brackets, and the closed bracket)"
		echo "and then run this program, and go to the \"Check an answer\" option, and paste it there."
		echo "Once you press enter, it will check if the key cooresponds to a badge, and will unlock it's respective badges."
		echo ""
		echo "You can also view all of your unlocked and locked badges in this program too in the third option."
		echo "Good luck and have fun!"
		echo ""
		echo ""
		echo "Oh, and that example key I showed you before? That's a valid key! Try it out!"
		echo ""
		echo ""
		echo "---------------------------------------------------------"
		echo ""
	elif [[ $opt -eq 2 ]]; then
		clear
		while true; do
			echo "Enter key (type \"q\" to quit): "
			read -r inp
			
			if [[ $inp == "q" ]]; then
				break
			fi

			key=$(echo -n $inp | md5sum | awk '{print $1}')
			found=0

			while read line; do
				name=$(echo $line | awk '{print $1}')
				x=$(echo $line | awk '{print $3}')
				color=$(echo -e "\e[32m${name}\e[0m")
				if [[ "$key" == "$x" ]]; then
					old="${name} : ${key}"
					new="${color} : ${inp}"
					echo "\"$inp\" is correct!"
					echo "Badge \"$name\" has been unlocked!"
					sed -i "s|${old}|${new}|g" ".badges.txt"
					found=1
				elif [[ "$inp" == "$x" && "$inp" != "|" ]]; then
					echo "$name has already been found!"
					found=1
				fi
				prev="$line"
			done < ".badges.txt"

			if [[ $found -eq 0 ]]; then
				echo "No key matches :("
			fi
			echo ""
		done
	elif [[ $opt -eq 3 ]]; then
		clear
		echo ""
		echo ""
		cat ".badges.txt"
		echo ""
		echo "---------------------------------------------------------"
		echo ""
	else
		echo "Not a valid option"
	fi
done
clear
