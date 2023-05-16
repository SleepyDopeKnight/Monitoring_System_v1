#!/bin/bash

startTime=$(date +"%s.%N")

function total_number_of_folders {
    echo "Total number of folders (including all nested ones) = $(ls -l $param | grep -c ^d)"
}

function top_5_folders_of_maximum_size {
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    i=1
    for ((var=1; var<6; var++, i++))
    do
        name=$(sudo du -m $param | sort -n | sed -n "$var"p | awk '{print $2}')
        size=$(sudo du -m $param | sort -n | sed -n "$var"p | awk '{print $1}')
        if ! [ -z "$name" ] && ! [ -z "$size" ]; then
            echo "$i - $name, $size MB"
        fi
    done
}

function total_number_of_files {
    echo "Total number of files = $(sudo ls -laR $param | grep -c ^-)"
}

function number_of {
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $(sudo find $param -type f -name "*.conf" | wc -l)"
    echo "Text files = $(sudo find $param -type f -name "*.txt" | wc -l)"
    echo "Executable files = $(sudo find $param -type f -name -executable | wc -l)"
    echo "Log files (with the extension .log) = $(sudo find $param -type f -name "*.log" | wc -l)"
    echo "Archive files = $(sudo find $param -type f -name "*.7z" -o -name "*.zip" -o -name "*.rar" -o -name "*.tar" | wc -l)"
    echo "Symbolic links = $(sudo find $param -type l | wc -l)"
}

function top_10_files_of_maximum_size {
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    i=1
    for ((var=1; var<11; var++, i++))
    do
        name=$(sudo find $param -type f -exec du -h {} + | sort -hr | sed -n "$var"p | awk '{print $2}')
        size=$(sudo find $param -type f -exec du -h {} + | sort -hr | sed -n "$var"p | awk '{print $1}')
        if ! [ -z "$name" ] && ! [ -z "$size" ]; then
            echo "$i - $name, $size, ${name##*.}"
        fi
    done
}

function top_10_executable_files {
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    i=1
    for ((var=1; var<11; var++, i++))
    do
        name=$(sudo find $param -type f -executable -exec du -h {} + | sort -hr | sed -n "$var"p | awk '{print $2}')
        size=$(sudo find $param -type f -executable -exec du -h {} + | sort -hr | sed -n "$var"p | awk '{print $1}')
        if [[ "${name##*.}" = "exe" ]]; then
            hash=$(md5sum ${name[$i]} | awk '{print $1}')
            echo "$i - $name, $size, $hash"
        fi
    done
}

total_number_of_folders
top_5_folders_of_maximum_size
total_number_of_files
number_of
top_10_files_of_maximum_size
top_10_executable_files
endTime=$(date +"%s.%N")
runTime=$(bc <<< "$startTime - $endTime")
Time=$(echo "$runTime" | sed 's/-/0/g')
echo "Script execution time (in seconds) = $Time"
