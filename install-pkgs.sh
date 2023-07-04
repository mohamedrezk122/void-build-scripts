#!/bin/bash 

# __     __    _     _ ____        _ _     _
# \ \   / /__ (_) __| | __ ) _   _(_) | __| |
#  \ \ / / _ \| |/ _` |  _ \| | | | | |/ _` |
#   \ V / (_) | | (_| | |_) | |_| | | | (_| |
#    \_/ \___/|_|\__,_|____/ \__,_|_|_|\__,_|

# Author : Mohamed Rezk
# GitHub : github.com/mohamedrezk122 

#colors
RED="\e[31m"
GREEN="\e[32m"
NC="\e[0m"

# installation command depending on the distro you use 
install(){ 
    # silent installation 
    sudo xbps-install $1 -y >/dev/null
}
error() {
    # redirect stderr to stdout 
    printf "%s\n" "$1" >&2
    exit 1
}
update(){
    echo -e "# Updating system and installed packges...."
    sudo xbps-install -Suv
}

install-from-csv(){
    while IFS="," read pkg prompt 
    do 
        # removing leading and trailing spaces from vars 
        pkg=`echo $pkg | xargs`  
        prompt=`echo $prompt | xargs`
        # installing package
        echo  -e "# Installing ${GREEN}$pkg${NC} ($prompt)"
        install $pkg || error "not found"
    done < <( tail -n +2 $1 ) #ignore header row
}

install-from-csv $1
update 

