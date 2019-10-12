#!/bin/bash

BLINK="\e[5m"
UNBLINK="\e[25m"

RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
MAGENTA="\e[95m"
CYAN="\e[96m"
NC="\e[39m\e[49m"

width=81
height=45

terminate() {
    #echo "$1"
    if [ -z ${SOUND+x} ]; then
        echo ""
    else 
        kill $SOUND
    fi
    stty echo
    exit 0
}

print_win() {
    clear
    echo -e "$GREEN

██╗   ██╗ ██████╗ ██╗   ██╗    ██╗    ██╗ ██████╗ ███╗   ██╗
╚██╗ ██╔╝██╔═══██╗██║   ██║    ██║    ██║██╔═══██╗████╗  ██║
 ╚████╔╝ ██║   ██║██║   ██║    ██║ █╗ ██║██║   ██║██╔██╗ ██║
  ╚██╔╝  ██║   ██║██║   ██║    ██║███╗██║██║   ██║██║╚██╗██║
   ██║   ╚██████╔╝╚██████╔╝    ╚███╔███╔╝╚██████╔╝██║ ╚████║
   ╚═╝    ╚═════╝  ╚═════╝      ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═══╝
                                                            $NC"
    echo -e "$YELLOW*******************************************************************************
          |                   |                  |                     |
 _________|________________.=\"\"_;=.______________|_____________________|_______
|                   |  ,-\"_,=\"\"     \`\"=.|                  |
|___________________|__\"=._o\`\"-._        \`\"=.______________|___________________
          |                \`\"=._o\`\"=._      _\`\"=._                     |
 _________|_____________________:=._o \"=._.\"_.-=\"'\"=.__________________|_______
|                   |    __.--\" , ; \`\"=._o.\" ,-\"\"\"-._ \".   |
|___________________|_._\"  ,. .\` \` \`\` ,  \`\"-._\"-._   \". '__|___________________
          |           |o\`\"=._\` , \"\` \`; .\". ,  \"-._\"-._; ;              |
 _________|___________| ;\`-.o\`\"=._; .\" \` '\`.\"\\\` . \"-._ /_______________|_______
|                   | |o;    \`\"-.o\`\"=._\`\`  '\` \" ,__.--o;   |
|___________________|_| ;     (#) \`-.o \`\"=.\`_.--\"_o.-; ;___|___________________
____/______/______/___|o;._    \"      \`\".o|o_.--\"    ;o;____/______/______/____
/______/______/______/_\"=._o--._        ; | ;        ; ;/______/______/______/_
____/______/______/______/__\"=._o--._   ;o|o;     _._;o;____/______/______/____
/______/______/______/______/____\"=._o._; | ;_.--\"o.--\"_/______/______/______/_
____/______/______/______/______/_____\"=.o|o_.--\"\"___/______/______/______/____
/______/______/______/______/______/______/______/______/______/______/[TomekK]
*******************************************************************************$NC"
}

print_lost() {
    clear
    echo -e "$RED▓██   ██▓ ▒█████   █    ██    ▓█████▄  ██▓▓█████ ▓█████▄                
 ▒██  ██▒▒██▒  ██▒ ██  ▓██▒   ▒██▀ ██▌▓██▒▓█   ▀ ▒██▀ ██▌               
  ▒██ ██░▒██░  ██▒▓██  ▒██░   ░██   █▌▒██▒▒███   ░██   █▌               
  ░ ▐██▓░▒██   ██░▓▓█  ░██░   ░▓█▄   ▌░██░▒▓█  ▄ ░▓█▄   ▌               
  ░ ██▒▓░░ ████▓▒░▒▒█████▓    ░▒████▓ ░██░░▒████▒░▒████▓  ██▓  ██▓  ██▓ 
   ██▒▒▒ ░ ▒░▒░▒░ ░▒▓▒ ▒ ▒     ▒▒▓  ▒ ░▓  ░░ ▒░ ░ ▒▒▓  ▒  ▒▓▒  ▒▓▒  ▒▓▒ 
 ▓██ ░▒░   ░ ▒ ▒░ ░░▒░ ░ ░     ░ ▒  ▒  ▒ ░ ░ ░  ░ ░ ▒  ▒  ░▒   ░▒   ░▒  
 ▒ ▒ ░░  ░ ░ ░ ▒   ░░░ ░ ░     ░ ░  ░  ▒ ░   ░    ░ ░  ░  ░    ░    ░   
 ░ ░         ░ ░     ░           ░     ░     ░  ░   ░      ░    ░    ░  
 ░ ░                           ░                  ░        ░    ░    ░  $NC"
    play -q dead.ogg
}

print_logo() {
    echo -e "$YELLOW   ▄████████              ▄▄▄▄███▄▄▄▄      ▄████████  ▄███████▄     ▄████████           ▄█  ███▄▄▄▄      ▄██████▄  
  ███    ███            ▄██▀▀▀███▀▀▀██▄   ███    ███ ██▀     ▄██   ███    ███          ███  ███▀▀▀██▄   ███    ███ 
  ███    ███            ███   ███   ███   ███    ███       ▄███▀   ███    █▀           ███▌ ███   ███   ███    █▀  
  ███    ███            ███   ███   ███   ███    ███  ▀█▀▄███▀▄▄  ▄███▄▄▄              ███▌ ███   ███  ▄███        
▀███████████ ▀█████████ ███   ███   ███ ▀███████████   ▄███▀   ▀ ▀▀███▀▀▀   ▀█████████ ███▌ ███   ███ ▀▀███ ████▄  
  ███    ███            ███   ███   ███   ███    ███ ▄███▀         ███    █▄           ███  ███   ███   ███    ███ 
  ███    ███            ███   ███   ███   ███    ███ ███▄     ▄█   ███    ███          ███  ███   ███   ███    ███ 
  ███    █▀              ▀█   ███   █▀    ███    █▀   ▀████████▀   ██████████          █▀    ▀█   █▀    ████████▀  
                                                                                                
   ▄██████▄     ▄████████    ▄▄▄▄███▄▄▄▄      ▄████████                                         
  ███    ███   ███    ███  ▄██▀▀▀███▀▀▀██▄   ███    ███                                         
  ███    █▀    ███    ███  ███   ███   ███   ███    █▀                                          
 ▄███          ███    ███  ███   ███   ███  ▄███▄▄▄                                             
▀▀███ ████▄  ▀███████████  ███   ███   ███ ▀▀███▀▀▀                                             
  ███    ███   ███    ███  ███   ███   ███   ███    █▄                                          
  ███    ███   ███    ███  ███   ███   ███   ███    ███                                         
  ████████▀    ███    █▀    ▀█   ███   █▀    ██████████                                         
                                                                                                

$NC"
}

print_intro() {
    print_logo
    echo -e "\tNavigate with$GREEN w, a, s, d$NC. Exit with$GREEN q$NC."
    echo ""
    echo -e "\t ${BLINK}1$UNBLINK ) Start Game"
    echo -e "\t ${BLINK}2$UNBLINK ) Exit"
    
    #Play intro.ogg
    play -q intro.ogg repeat &
    SOUND=$!
    
    select_intro
}

select_difficulty() {
    clear
    print_logo
    echo -e "\tSelect the difficulty of the game:"
    echo ""
    echo -e "\t ${BLINK}1$UNBLINK ) Easy"
    echo -e "\t ${BLINK}2$UNBLINK ) Medium"
    echo -e "\t ${BLINK}3$UNBLINK ) Hard"
    
    read -s -n 1 move
	case "$move" in
		'1')
            width=11
            height=11
			start_game
			;;
		'2')
            width=41
            height=41
			start_game
			;;
		'3')
            width=81
            height=45
			start_game
			;;
	esac
	terminate
}

select_intro() {
    read -s -n 1 move
	case "$move" in
		'1')
            #if [ -z ${SOUND+x} ]; then
            #    echo "Starting game"
            #else 
            #    kill $SOUND
            #fi
			#Start Game
			select_difficulty
			;;
		'2') 
			#QUIT
			clear
			terminate
			;;
	esac
	terminate
}

init_maze() {
    for ((y=0; y<$height; y++)) ; do
        for ((x=1; x<$(($width-1)); x++)) ; do
            array[$((y * $width + x))]="█"
        done
        array[$((y * $width + 0))]=" "
        array[$((y * $width + ($width - 1)))]=" "
    done
    for ((x=0; x<$width; x++)) ; do
        array[$x]=" "
        array[$((($height - 1) * $width + x))]=" "
    done
}

carve_maze() {
   local index=$1
   local dir=$RANDOM
   local i=0
   array[$index]=" "
   while [ $i -le 4 ] ; do
      local offset=0
      case $((dir % 4)) in
         0) offset=1 ;;
         1) offset=-1 ;;
         2) offset=$width ;;
         3) offset=$((-$width)) ;;
      esac
      local index2=$((index + offset))
      if [ "${array[$index2]}" = "█" ] ; then
         local nindex=$((index2 + offset))
         if [ "${array[$nindex]}" = "█" ] ; then
            array[$index2]=" "
            carve_maze $nindex
            i=0
            dir=$RANDOM
            index=$nindex
         fi
      fi
      i=$((i + 1))
      dir=$((dir + 1))
   done
}

follow() {
	if [ $(($steps_done%2)) -eq 0 ]; then
		# move enemy
		pos=$((($e_ypos * $width) + $e_xpos))
		if [ $xpos -lt $e_xpos ]  && [ "${array[$(($pos-1))]}" != "█" ]; then
			let e_xpos=$e_xpos-1
			return
		elif [ $xpos -gt $e_xpos ] && [ "${array[$(($pos+1))]}" != "█" ]; then
			let e_xpos=$e_xpos+1
			return
		fi
		if [ $ypos -lt $e_ypos ] && [ "${array[$(($pos-$width))]}" != "█" ]; then
			let e_ypos=$e_ypos-1
		elif [ $ypos -gt $e_ypos ] && [ "${array[$(($pos+$width))]}" != "█" ]; then
			let e_ypos=$e_ypos+1
		fi
	fi
}

follow_a_star() {
    follow
}

go_up() {
	#clear
	follow
	#tput cup 0 0
	if [ $xpos -eq $e_xpos ] && [ $ypos -eq $e_ypos ]; then
		state=0
	elif [ $xpos -eq $g_xpos ] && [ $ypos -eq $g_ypos ]; then
		state=2
	fi
	if [ $state -eq 2 ]; then
        print_win
		terminate #"WON with $steps_done steps"
	fi
	if [ $state -eq 0 ]; then
		print_lost
		terminate
	fi
	wait_input
}

wait_input() {
	tput cup $height 0
	read -s -n 1 move
	#echo "$move"
	pos=$(($ypos*$width+$xpos))
	case "$move" in
		'w') 
			#"UP"
			new_pos=$(($pos-$width))
			if [ $new_pos -gt 0  ] && [ "${array[$new_pos]}" != "█" ]; then
				let ypos=$ypos-1
				let steps_done=$steps_done+1
			fi
			;;
		'a') 
			#"LEFT"
			new_pos=$((($pos % $width)-1))
			if [ $new_pos -gt 0 ] && [ "${array[$(($pos-1))]}" != "█" ]; then
				let xpos=$xpos-1
				let steps_done=$steps_done+1
			fi
			;;
		's') 
			#"DOWN"
			new_pos=$(($pos+$width))
			end=$((($width * $height) - 1))
			if [ $new_pos -lt $(($end-1)) ] && [ "${array[$new_pos]}" != "█" ]; then
				let ypos=$ypos+1
				let steps_done=$steps_done+1
			fi
			;;
		'd') 
			#"RIGHT"
			new_pos=$((xpos+1))
			if [ $new_pos -lt $(($width-1)) ] && [ "${array[$(($pos+1))]}" != "█" ]; then
				let xpos=$xpos+1
				let steps_done=$steps_done+1
			fi
			;;
		'q') 
            clear
            terminate
            ;;
	esac
	print_over
}

print_over() {
	# player
	tput cup $cache_ypos $cache_xpos
	echo -n " "
	tput cup $ypos $xpos
	cache_xpos=$xpos
	cache_ypos=$ypos
	echo -ne "$RED♥$NC"

	# enemy 
	tput cup $cache_e_ypos $cache_e_xpos
	echo -n " "
	tput cup $e_ypos $e_xpos
	cache_e_xpos=$e_xpos
	cache_e_ypos=$e_ypos
	echo -ne "$BLINK$GREEN☼$NC$UNBLINK"
	
	go_up
}

init_game() {
    # random enemy needs fix
    e_xpos=$((RANDOM % $width))
    e_ypos=$((RANDOM % $height))
    cache_e_xpos=$e_xpos
    cache_e_ypos=$e_ypos
    
    init_maze
    carve_maze $((2 * $width + 2))

    xpos=2
    ypos=1
    cache_xpos=$xpos
    cache_ypos=$ypos

    g_xpos=$(($width - 3))
    g_ypos=$(($height -2))

    array[$(($ypos * $width + $xpos))]="$RED♥$NC"
    array[$(($e_ypos * $width + $e_xpos))]="$BLINK$GREEN☼$NC$UNBLINK"
    array[$(($g_ypos * $width + $g_xpos))]="$YELLOW⌂$NC"

    state=1

    steps_done=0
}

start_game () {
    init_game
    clear
    stty -echo
    for (( y=0; y<$height; y++ ))
    do
        for (( x=0; x<$width; x++ ))
        do
            dim=$(($y * $width + $x))
            pos=${array[$dim]}
            echo -ne "$pos"
        done
        echo ""
    done
    #play -q loop.ogg repeat &
    SOUND=$!
	wait_input
	#print_over
}

declare -a array
clear
print_intro
terminate
