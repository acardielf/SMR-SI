#!/bin/bash

# Mensaje de inicio
clear
echo 
echo "Loading dependencies..."
sudo apt install -qq -y cmatrix
clear
echo
echo "Loading dependencies..."
echo 
echo "Decrypting password... please wait... it's hard!"
sleep 2
echo
cowsay -f milk "You have been infected by a so dangerous virus for linux"
sleep 4
echo
echo "Starting the simulator... Bye bye for 60 seconds or... what if you kill me?"
sleep 3
cmatrix -L &
PID=$!
sleep 2
kill $PID
cowsay -f tux "Maybe searching in Google..."
