#!/bin/bash

sudo chmod +x ./prInfo.sh
if [ $# != 0 ]; then
    echo "Inccorrect params input"
else
    sudo chmod +x ./info.sh
    ./info.sh
fi