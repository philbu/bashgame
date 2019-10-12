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

terminate() {
    #echo "$1"
    if [ -z ${SOUND+x} ]; then
        echo ""
    else 
        kill $SOUND
    fi
    exit 0
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

print_intro() {
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

    echo -e "\tNavigate with$GREEN w, a, s, d$NC. Exit with$GREEN q$NC."
    echo ""
    echo -e "\t ${BLINK}1$UNBLINK ) Start Game"
    echo -e "\t ${BLINK}2$UNBLINK ) Exit"
    
    #Play intro.ogg
    play -q intro.ogg repeat &
    SOUND=$!
    
    select_intro
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
			start_game
			;;
		'2') 
			#QUIT
			clear
			terminate
			;;
		'q') terminate;;
	esac
	print_over
}

width=81
height=45

end=$((($width * $height) - 1))

#echo "$width $height $end"
declare -a array

e_xpos=$((RANDOM % $width))
e_ypos=$((RANDOM % $height))
cache_e_xpos=$e_xpos
cache_e_ypos=$e_ypos

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

clear

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
		terminate "WON with $steps_done steps"
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

start_game () {
    clear
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

print_intro
exit 0
