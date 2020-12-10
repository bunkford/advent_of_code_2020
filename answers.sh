#!/usr/bin/env bash
clear
printf "%b" "\e[4;33mAdvent of Code 2020\e[0m"
for i in {1..25}; 
do 
    if test -f "aoc_2020_$(printf "%02d" $i)" 
    then 
        printf "%b" "\n\n\e[1;34mDay $(printf "%02d" $i)\e[0m:\n"
        time ./aoc_2020_$(printf "%02d" $i)
    fi
done
