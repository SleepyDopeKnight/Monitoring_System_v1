#!/bin/bash

inputFile="test.txt"
touch $inputFile

function data_setup {
    hostname=$(hostname)
    timezone="$(cat /etc/timezone) UTC $(date +"%z")"
    user=$(whoami)
    os=$(cat /etc/issue | sed -n '1'p | awk '{printf("%s %s", $1, $2)}')
    date=$(date +"%d %b %Y %H:%M:%S")
    uptime=$(uptime -p)
    uptime_sec=$(awk '{print $1}' /proc/uptime)
    ip=$(hostname -I | awk '{print $1}')
    mask=$(ipcalc $ip | grep "Netmask" | awk '{print $2}')
    gw=$(ip route | sed -n '1'p | awk '{printf("%s", $3)}')
    ram_total=$(free | sed -n '2'p | awk '{printf("%.3f Gb", $2 / 1024 / 1024)}')
    ram_used=$(free | sed -n '2'p | awk '{printf("%.3f Gb", $3 / 1024 / 1024)}')
    ram_free=$(free | sed -n '2'p | awk '{printf("%.3f Gb", $4 / 1024 / 1024)}')
    space_root=$(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')
    space_root_used=$(df | sed -n '4'p | awk '{printf("%.2f Gb", $3 / 1024 / 1024)}')
    space_root_free=$(df | sed -n '4'p | awk '{printf("%.2f Gb", $4 / 1024 / 1024)}')
}

function data_output {
    echo "HOSTNAME = $hostname" | tee -a $inputFile
    echo "TIMEZONE = $timezone" | tee -a $inputFile
    echo "USER = $user" | tee -a $inputFile
    echo "OS = $os" | tee -a $inputFile
    echo "DATE = $date" | tee -a $inputFile
    echo "UPTIME = $uptime" | tee -a $inputFile
    echo "UPTIME_SEC = $uptime_sec" | tee -a $inputFile
    echo "IP = $ip" | tee -a $inputFile
    echo "MASK = $mask" | tee -a $inputFile
    echo "GATEWAY = $gw" | tee -a $inputFile
    echo "RAM_TOTAL = $ram_total" | tee -a $inputFile
    echo "RAM_USED = $ram_used" | tee -a $inputFile
    echo "RAM_FREE = $ram_free" | tee -a $inputFile
    echo "SPACE_ROOT = $space_root" | tee -a $inputFile
    echo "SPACE_ROOT_USED = $space_root_used" | tee -a $inputFile
    echo "SPACE_ROOT_FREE = $space_root_free" | tee -a $inputFile
    echo "----------------------------------------"
    read -p "if you want to save the data to a file, write Y/N: " answer
    if [[ $answer == Y || $answer == y ]]; then
        mv $inputFile $(date '+%d_%m_%Y_%H_%M_%S').status
    else
        rm test.txt
    fi
}

data_setup
data_output