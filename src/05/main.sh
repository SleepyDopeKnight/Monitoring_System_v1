#!/bin/bash
  
if [ $# != 1 ]; then
    echo "Inccorrect params input"
elif [[ "${1: -1}" != "/" ]]; then
    echo "Inccorrect params input"
elif [[ -d "$1" ]]; then
    end=$(echo $1 | tail -c 2)
    if [[ "$end" = "/" ]]; then
            export param=$1
            sudo chmod +x ./info.sh
            ./info.sh
    fi
fi