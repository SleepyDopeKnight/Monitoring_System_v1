#!/bin/bash

if [ $# != 1 ]
then
echo "Inccorrect params input"
elif [[ $1 =~ [0-9] ]]
then
echo "Inccorrect params input"
elif [[ $1 =~ [./,+-/%/^] ]]
then
echo "Inccorrect params input"
else
echo $1
fi