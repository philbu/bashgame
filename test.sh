#!/bin/bash

width=$((RANDOM % 50))
height=$((RANDOM % $width))

xpos=3
ypos=5
cache_xpos=$xpos
cache_ypos=$ypos

e_xpos=$((RANDOM % $width))
e_ypos=$((RANDOM % $height))
cache_e_xpos=$e_xpos
cache_e_ypos=$e_ypos

g_xpos=$((RANDOM % $width))
g_ypos=$((RANDOM % $height))

g_height=$(($height-1))


w_xpos=(1 3 6)
x_ypos=(4 5 8)

state=1

steps_done=0

clear

follow() {
	if [ $(($steps_done%2)) -eq 0 ]; then
		# move enemy
		if [ $xpos -lt $e_xpos ]; then
			let e_xpos=$e_xpos-1
			return
		elif [ $xpos -gt $e_xpos ]; then
			let e_xpos=$e_xpos+1
			return
		fi
		if [ $ypos -lt $e_ypos ]; then
			let e_ypos=$e_ypos-1
		elif [ $ypos -gt $e_ypos ]; then
			let e_ypos=$e_ypos+1
		fi
	fi
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
		clear
		echo "WON with $steps_done steps"
		exit 0
	fi
	if [ $state -eq 0 ]; then
		clear
		echo "LOST"
		exit 0
	fi
	wait_input
}

wait_input() {
	tput cup $height 0
	read -n 1 move
	let steps_done=$steps_done+1
	#echo "$move"
	case "$move" in
		'w') 
			echo "UP"
			if [ $ypos -gt 0 ]; then
				let ypos=$ypos-1
			fi
			;;
		'a') 
			echo "LEFT"
			if [ $(($xpos-1)) -gt 0 ]; then
				let xpos=$xpos-1
			fi
			;;
		's') 
			echo "DOWN"
			if [ $(($ypos+1)) -lt $height ]; then
				let ypos=$ypos+1
			fi
			;;
		'd') 
			echo "RIGHT"
			if [ $xpos -lt $width ]; then
				let xpos=$xpos+1
			fi
			;;
		'q') exit 0;;
	esac
	print_over
}

print_over() {
	# player
	tput cup $cache_ypos $(($cache_xpos-1))
	echo -n " "
	tput cup $ypos $(($xpos-1))
	cache_xpos=$xpos
	cache_ypos=$ypos
	echo -n "I"

	# enemy 
	tput cup $cache_e_ypos $cache_e_xpos
	echo -n " "
	tput cup $e_ypos $e_xpos
	cache_e_xpos=$e_xpos
	cache_e_ypos=$e_ypos
	echo -n "X"
	
	go_up
}

print_all () {
	y=0
	while [ $y -lt $height ]; do
		x=0
		while [ $x -lt $width ]; do
			let x=$x+1
			if [ $ypos -eq $y ] && [ $xpos -eq $x ]; then
				echo -n "I"
			elif [ $x -eq $e_xpos ] && [ $y -eq $e_ypos ]; then
				echo -n "X"
			elif [ $x -eq $g_xpos ] && [ $y -eq $g_ypos ]; then
				echo -n "S"
			elif [ $y -eq $g_height ]; then
				echo -n "-"
			else
				echo -n " "
			fi

		done
		echo ""
		let y=$y+1
	done
	wait_input
	#print_over
}

randomize_maze() {
	echo "Test"	
}

print_all

