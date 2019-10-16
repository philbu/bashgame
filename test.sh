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

enemy_image="$BLINK$GREEN☼$NC$UNBLINK"
player_image="$RED♥$NC"

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

print_monster() {
    echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWX0kkkkOKNWMMMMMMMMMMN0kxdddxkOKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0o:,'...,;:coOWMMMMMMWOlll:'.'''.'cOWMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMWXXWMMMMMMMMMMMMMMMM0,.',,lxOKKXKkkXMMMMMMWKKWWNOxo;,;'.'kWMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMNxdkOKWMMMMMMMMMMMMWo .;;OWMMMMMMMMMMMMMMMMMMMMMMMWx.',. ;KMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMNOxOkkKWMMMMMMMMMMWo.,;,codddxkKNNXXXNNNXXKkooddxdc;,. .cKMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMKxO0OkOXWMMMMMMMMMK:..........';;,,;::;,,'...,,,;;,..;xXMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMWOOK0OOx0WMMMMMMMMMXd;;;;'...','...........,,'..';:lONMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MWWMMMMMMMMMKOKK00kOWMMMMMMMMMMMWN0l;'.  .'.',,',,,'.;, ..:xKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
M0ONMMKOKXKKOk0XK0kkNMMMMMMMMMMMMXl''..'''',,;;,;,',,;,''',;cxKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
M0dKM0,.cxxkO00XNKOx0WMMMMMMMMMWOl;;'..:;..'.',;,'......'...';:kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MXk0NKl'.:dkOOO0OkOOkXMMMMMMMMMO:;cldd0Kl....,;:;,...',cl:,'',,dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MXkk0KKk;.'dkkKKX0kkx0MMMMMMMMMO:dKNWMMXo,....';'....,:kKkdddl;oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MXOxkKK0x;.':kWMMMNko0MMMMMMMMMN000OOOkl,';c;'''',;::'.,cdkO0OkKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MWKkdO0xOO:..;OWMMM0lOMMMMMMMNOo:,'',,,,'.;l;lxoddcdO, .',,;:clodx0WMMMMMMMMMMMMMMMMMMMMMMMMMM
MMWKxkOOXWXl..'o00xoo0MMMMMMXd'.',,;:::;;,;oxx0KKOx0k;,,'''',;;::::dKWMMMMMMMMMMMMMMMMMMMMMMMM
MMMN0kOOXMMNd..'::;::lxXWMMNd,..;;:cc::;;;:coxO00kolc;;;;;;,,,;;:;::cOWMMMMMMMMMMMMMMMMMMMMMMM
MMMMNK0kONMMWd',;'';;::lKMWO:..';;c:;;;;;;;::;clll;;;;;:cc::;;;;::;:;lKMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMWX0XWMWd.';...';::OMKl,..;::,.,;;;;;,,,;::::;,,,;:::c;',,,;;::;;oKMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMWd,;;,'..;;;o0o'.',:c:..;;;:::;''',,;;,'',;:::c:',. ...';::lONMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMNOocc;..';;;;...';;;'.,;;;:cc;,'.',,;;,',;:ccc:','..  ...;::lONMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMWWN0:..';;,'..''..'.;;;;:::;,,,,;;;;;,,;cccc;':xko:,,...,;:;lxKWMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMXc..';;,'',,',:;';;;;;;;;;;,,'',,,,,,,,,,cOWMWNXk:. .',;''c0MMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMXl...,;;;;:okXXd,'','''..............',oXMMMMMMXo....';,.;kWMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMNd...,;;:dNMMMMO;,;...''..,'.',,,'';;c0MMMMMMMMNkc'..,;,:OMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMWx,..,cONMMMMM0c;;..',...'...''',',;dNMMMMMMMMMMNOc..;::xNMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMWO,..lXMMMMMMXc','.;,..'''...'''''.cXMMMMMMMMMMMM0,.'',:okKWMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMW0;..cKMMMMMWO;..... ..,'..'... ..,dKWMMMMMMMMMWx..',,:c::kWMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMK:..:0WMMMNOc,''... ... ......',::ckNMMMMMMMW0:'',',;::;cKMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMKc..,kKOxl:;;,'''.....   ...'..'::;l0WMMMMMWk:,.''',,:;:0MMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMXl..';::::c:;'.''....   ...;.  ,c:;c0MMMMMMKl,','',',l0WMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMO,...,:c:;'....,.....  ...'  .:c::;xWMMMMMWx;;,,:lx0NMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMXl;,...';,'... .,..........'. .,:c:;cOWMMMMMN0kOXWMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMXo';:;....,'.  .''.........,;.  ':cc::ckNMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMWx'.,;:;.......'''...'... ..,'  .:ccc:::c0MMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMXo.',,;:;....';co;...'......',,'.':ccc;,c0MMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMNo. .',,;;.....xNd'l0Kkcoc,oOOo::;,,'..,lKMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMWO:..''',;;'...dWNKWMMWNWXKWMMO:'';;'',;lKMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMXkoc::::::;;:ckNMMMMMMMMMMMMO:,',;;,',oXMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNKOkd:'',,;::kWMMMMMMMMMMMW0d:,'''.'c0MMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk;'....,ckXWMMMMMMMMMMMNd;..'.',dXMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx,...';::ckNWMMMMMMMMMWx:,,:;;;c0MMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXkc,'.';:cc:lxKMMMMMMMMMMXo;::c:;:kWMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNOxo;'''',;;:c:xXNMMMMMMMMMWOc;;,,:lxkOXWMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMWK0Oxolodc,'':dxl:dNMMMMMMMMMMMXxllollolok0O0XWMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMW0kOOxodxxdlloxk0OOXMMMMMMMMMMMW0kxlokOkxdkO0OkKWMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMNXXKK0K0OOOO0KKXNWMMMMMMMMMMMMN00K00KX0O0KKKXNWMMMMMMMMMMMMMMMMMMMM
MMWNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
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
            number_of_enemies=1
			start_game
			;;
		'2')
            width=41
            height=41
            number_of_enemies=2
			start_game
			;;
		'3')
            width=81
            height=45
            number_of_enemies=3
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
            math[$((y * $width + x))]=-1
        done
        array[$((y * $width + 0))]=" "
        math[$((y * $width + 0))]=0
        array[$((y * $width + ($width - 1)))]=" "
        math[$((y * $width + ($width - 1)))]=0
    done
    for ((x=0; x<$width; x++)) ; do
        array[$x]=" "
        array[$((($height - 1) * $width + x))]=" "
        math[$x]=0
        math[$((($height - 1) * $width + x))]=0
    done
}

carve_maze() {
   local index=$1
   local dir=$RANDOM
   local i=0
   array[$index]=" "
   math[$index]=0
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
            math[$index2]=0
            # spawn enemy at random
            local enemy_spawn_probability=$(($RANDOM % 20))
            if [ $number_of_enemies -gt 0 ] && [ $enemy_spawn_probability -eq 0 ]; then
                array[$index2]="$enemy_image"
                
                enemy_pos[$enemy_pos_size]=$index2
                # increase (size) index of enemy_pos array
                enemy_pos_size=$(($enemy_pos_size + 1))
                # decrease number of enemies after enemy added to avoid too many enemies
                number_of_enemies=$(($number_of_enemies - 1))
            fi
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
        # move enemies
        for (( c=0; c<$enemy_pos_size; c++ ))
        do
            # move enemy
            pos=${enemy_pos[$c]}
            #"UP"
            new_pos=$(($pos-$width))
            up=0
            if [ $new_pos -gt 0  ]; then
                up=${math[$new_pos]}
            fi
            
            #"LEFT"
            new_pos=$(($pos-1))
            left=0
            if [ $(($new_pos % $width)) -gt 0 ]; then
                left=${math[$new_pos]}
            fi
            
            #"DOWN"
            new_pos=$(($pos+$width))
            end=$((($width * $height) - 1))
            down=0
            if [ $new_pos -lt $end ]; then
                down=${math[$new_pos]}
            fi
            
            #"RIGHT"
            new_pos=$(($pos+1))
            right=0
            if [ $(($new_pos % $width)) -lt $(($width-1)) ]; then
                right=${math[$new_pos]}
            fi

            #up
            if [ $up -gt $left ] && [ $up -gt $down ] && [ $up -gt $right ]; then
                new_pos=$(($pos-$width))
                change_pos $pos $new_pos
                enemy_pos[$c]=$new_pos
            fi
            #left
            if [ $left -gt $up ] && [ $left -gt $down ] && [ $left -gt $right ]; then
                new_pos=$(($pos-1))
                change_pos $pos $new_pos
                enemy_pos[$c]=$new_pos
            fi
            #right
            if [ $right -gt $left ] && [ $right -gt $down ] && [ $right -gt $up ]; then
                new_pos=$(($pos+1))
                change_pos $pos $new_pos
                enemy_pos[$c]=$new_pos
            fi
            #down
            if [ $down -gt $left ] && [ $down -gt $up ] && [ $down -gt $right ]; then
                new_pos=$(($pos+$width))
                change_pos $pos $new_pos
                enemy_pos[$c]=$new_pos
            fi
        done
	fi
}

follow_a_star() {
    follow
}

go_up() {
	#clear
	follow
	#tput cup 0 0
	for (( c=0; c<$enemy_pos_size; c++ ))
    do
        if [ "$player_pos" = "${enemy_pos[$c]}" ]; then
            state=0
        fi
    done
	if [ $player_pos -eq $goal_pos ]; then
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
	case "$move" in
		'w') 
			#"UP"
			new_pos=$(($player_pos-$width))
			if [ $new_pos -gt 0  ] && [ "${array[$new_pos]}" != "█" ]; then
				change_player $player_pos $new_pos
				player_pos=$new_pos
				let steps_done=$steps_done+1
			fi
			;;
		'a') 
			#"LEFT"
			new_pos=$(($player_pos-1))
			if [ $(($new_pos % $width)) -gt 0 ] && [ "${array[$new_pos]}" != "█" ]; then
				change_player $player_pos $new_pos
				player_pos=$new_pos
				let steps_done=$steps_done+1
			fi
			;;
		's') 
			#"DOWN"
			new_pos=$(($player_pos+$width))
			end=$((($width * $height) - 1))
			if [ $new_pos -lt $end ] && [ "${array[$new_pos]}" != "█" ]; then
				change_player $player_pos $new_pos
				player_pos=$new_pos
				let steps_done=$steps_done+1
			fi
			;;
		'd') 
			#"RIGHT"
			new_pos=$(($player_pos+1))
			if [ $(($new_pos % $width)) -lt $(($width-1)) ] && [ "${array[$new_pos]}" != "█" ]; then
				change_player $player_pos $new_pos
				player_pos=$new_pos
				let steps_done=$steps_done+1
			fi
			;;
		'q') 
            clear
            terminate
            ;;
	esac
	go_up
}

change_pos() {
    old_pos=$1
    new_pos=$2
    old_x=$(($old_pos % $width))
    old_y=$((($old_pos-$old_x) / $width))
    new_x=$(($new_pos % $width))
    new_y=$((($new_pos-$new_x) / $width))
    tput cup $old_y $old_x
	echo -n " "
	tput cup $new_y $new_x
	echo -ne "$enemy_image"
}

change_player() {
    old_pos=$1
    new_pos=$2
    old_x=$(($old_pos % $width))
    old_y=$((($old_pos-$old_x) / $width))
    new_x=$(($new_pos % $width))
    new_y=$((($new_pos-$new_x) / $width))
    tput cup $old_y $old_x
	echo -n " "
	tput cup $new_y $new_x
	echo -ne "$player_image"
}

follow_map() {
    local pos=$2
    local counter=$1
    math[$pos]=$counter
    stack[0]=$pos
    counter_stack[0]=$counter
    local i=1
    
    while [ $i -ne 0 ]
    do
        i=$(($i-1))
        pos=${stack[$i]}
        ncounter=${counter_stack[$i]}
        #"LEFT"
        new_pos=$(($pos-1))
        if [ $(($new_pos % $width)) -gt 0 ] && [ "${math[$new_pos]}" == "0" ]; then
            math[$new_pos]=$(($ncounter-1))
            stack[$i]=$new_pos
            counter_stack[$i]=$(($ncounter-1))
            i=$((i+1))
        fi

        #"DOWN"
        new_pos=$(($pos+$width))
        end=$((($width * $height) - 1))
        if [ $new_pos -lt $end ] && [ "${math[$new_pos]}" == "0" ]; then
            math[$new_pos]=$(($ncounter-1))
            stack[$i]=$new_pos
            counter_stack[$i]=$(($ncounter-1))
            i=$((i+1))
        fi

        #"RIGHT"
        new_pos=$(($pos+1))
        if [ $(($new_pos % $width)) -lt $(($width-1)) ] && [ "${math[$new_pos]}" == "0" ]; then
            math[$new_pos]=$(($ncounter-1))
            stack[$i]=$new_pos
            counter_stack[$i]=$(($ncounter-1))
            i=$((i+1))
        fi

        #"UP"
        new_pos=$(($pos-$width))
        if [ $new_pos -gt 0  ] && [ "${math[$new_pos]}" == "0" ]; then
            math[$new_pos]=$(($ncounter-1))
            stack[$i]=$new_pos
            counter_stack[$i]=$(($ncounter-1))
            i=$((i+1))
        fi
    done
}

init_game() {
    enemy_pos_size=0
    
    init_maze
    carve_maze $((2 * $width + 2))
    
    player_pos=$(($width+2))
    
    follow_map 10000 $player_pos
    
    goal_pos=$((($height-2) * $width + ($width - 3)))

    array[$player_pos]="$player_image"
    array[$goal_pos]="$YELLOW⌂$NC"

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
	wait_input
}

declare -a enemy_pos
declare -a array
declare -a math
clear
print_intro
terminate
