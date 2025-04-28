#!/bin/bash


if [ "$1" == "--help" ];then
 echo "how to use --> $0 [n] [v] search_string textfile"
 echo "options"
 echo " -n: show the number of row" 
 echo " -v: give you the lines that not have the string you pass"
 echo " --help: give you this help message"
 exit 0
fi

if [ $# -lt 2 ]; then
 echo "how to use --> $0 [n] [v] search_string textfile"
 exit 1
fi

show_line_numbers=false
Invert_the_match=false


while getopts "nv" opt; do 
 case "$opt" in 
      n)  show_line_numbers=true;;
      v)  Invert_the_match=true;;
      *) echo "invalid opt: -$opt"
         echo "how to use --> $0 [n] [v] search_string textfile"
         exit 1
 esac	 
done
 shift $((OPTIND - 1))
 search_string=$1
 file_name=$2


if [ -z "$file_name" ] || [ -z "$search_string" ]; then
 echo "the file or string is missing "
 echo "how to use --> $0 [n] [v] search_string textfile"
 exit 1
fi

if [ ! -f $file_name ];then 
 echo "file not exist"
 echo "how to use --> $0 [n] [v] search_string textfile"
 exit 1
fi

grepoption="-i"

if [ "$Invert_the_match" = true ]; then
grepoption="$grepoption -v"
fi

if [ "$show_line_numbers" = true ]; then
grepoption="$grepoption -n"
fi


grep $grepoption  "$search_string" "$file_name"
