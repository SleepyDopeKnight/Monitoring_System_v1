#!/bin/bash

function colors {
    arr[0]=$param1;
    arr[1]=$param2;
    arr[2]=$param3;
    arr[3]=$param4;

    for i in 0 1 2 3; do
        if [[ ${arr[$1]} < 1 || ${arr[$1]} > 6 ]]; then
            echo "Wrong arguments. Try again."
            exit 1
        fi
    done

    if [[ ${arr[0]} == ${arr[1]} ]]; then
        echo "The background and the color of the text cannot be the same! Try again."
        exit 1
    elif [[ ${arr[2]} == ${arr[3]} ]]; then
        echo "The background and the color of the text cannot be the same! Try again."
        exit 1
    fi

    whiteF="\033[107m"; redF="\033[41m"; greenF="\033[42m"; blueF="\033[44m"; purpleF="\033[45m"; blackF="\033[40m"
    whiteT="\033[97m"; redT="\033[31m"; greenT="\033[32m"; blueT="\033[34m"; purpleT="\033[35m"; blackT="\033[30m"
    reset="\e[0m"

    for i in 0 2; do
        if [[ ${arr[$i]} == 1 ]]; then 
            narr[$i]=$whiteF
        elif [[ ${arr[$i]} == 2 ]]; then 
            narr[$i]=$redF
        elif [[ ${arr[$i]} == 3 ]]; then 
            narr[$i]=$greenF
        elif [[ ${arr[$i]} == 4 ]]; then 
            narr[$i]=$blueF
        elif [[ ${arr[$i]} == 5 ]]; then 
            narr[$i]=$purpleF
        elif [[ ${arr[$i]} == 6 ]]; then 
            narr[$i]=$blackF
        fi
    done

    for i in 1 3; do
        if [[ ${arr[$i]} == 1 ]]; then 
            narr[$i]=$whiteT
        elif [[ ${arr[$i]} == 2 ]]; then 
            narr[$i]=$redT
        elif [[ ${arr[$i]} == 3 ]]; then 
            narr[$i]=$greenT
        elif [[ ${arr[$i]} == 4 ]]; then 
            narr[$i]=$blueT
        elif [[ ${arr[$i]} == 5 ]]; then 
            narr[$i]=$purpleT
        elif [[ ${arr[$i]} == 6 ]]; then 
            narr[$i]=$blackT
        fi
    done
}

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
    colors
    echo -e "${narr[0]}${narr[1]}HOSTNAME${reset} = ${narr[2]}${narr[3]}$hostname${reset}"
    echo -e "${narr[0]}${narr[1]}TIMEZONE${reset} = ${narr[2]}${narr[3]}$timezone${reset}"
    echo -e "${narr[0]}${narr[1]}USER${reset} = ${narr[2]}${narr[3]}$user${reset}"
    echo -e "${narr[0]}${narr[1]}OS${reset} = ${narr[2]}${narr[3]}$os${reset}"
    echo -e "${narr[0]}${narr[1]}DATE${reset} = ${narr[2]}${narr[3]}$date${reset}"
    echo -e "${narr[0]}${narr[1]}UPTIME${reset} = ${narr[2]}${narr[3]}$uptime${reset}"
    echo -e "${narr[0]}${narr[1]}UPTIME_SEC${reset} = ${narr[2]}${narr[3]}$uptime_sec${reset}"
    echo -e "${narr[0]}${narr[1]}IP${reset} = ${narr[2]}${narr[3]}$ip${reset}"
    echo -e "${narr[0]}${narr[1]}MASK${reset} = ${narr[2]}${narr[3]}$mask${reset}"
    echo -e "${narr[0]}${narr[1]}GATEWAY${reset} = ${narr[2]}${narr[3]}$gw${reset}"
    echo -e "${narr[0]}${narr[1]}RAM_TOTAL${reset} = ${narr[2]}${narr[3]}$ram_total${reset}"
    echo -e "${narr[0]}${narr[1]}RAM_USED${reset} = ${narr[2]}${narr[3]}$ram_used${reset}"
    echo -e "${narr[0]}${narr[1]}RAM_FREE${reset} = ${narr[2]}${narr[3]}$ram_free${reset}"
    echo -e "${narr[0]}${narr[1]}SPACE_ROOT${reset} = ${narr[2]}${narr[3]}$space_root${reset}"
    echo -e "${narr[0]}${narr[1]}SPACE_ROOT_USED${reset} = ${narr[2]}${narr[3]}$space_root_used${reset}"
    echo -e "${narr[0]}${narr[1]}SPACE_ROOT_FREE${reset} = ${narr[2]}${narr[3]}$space_root_free${reset}"
}

data_setup
data_output