#!/bin/bash

# Inspired by https://www.banjocode.com/post/bash/flags-bash

R=$(tput setaf 1) # Red
G=$(tput setaf 2) # Green
W=$(tput setaf 7) # White
bold=$(tput bold)
normal=$(tput sgr0)
redbold="${R}${bold}"
c="${W}${normal}"

# Files that start with .[a-zA-Z]* that we should not link:
SKIP_FILES=".git .gitignore"

function usage() {
    cat <<USAGE

    Usage: $0 [--overwrite]

    Options:
        -f, --force, --overwrite: overwrite existing files
        -h, --help:  show help text
USAGE
    exit 1
}

# Repeatedly ask for yes or no
function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;  
            [Nn]*) return 1 ;;
        esac
    done
}

# if [ $# -eq 0 ]; then
#     usage
#     exit 1
# fi

OVERWRITE=false

# If not interactive, overwrite
# case $- in
#     *i*) ;;
#       *) OVERWRITE=true;;
# esac

while [ "$1" != "" ]; do
    case $1 in
    -f | --overwrite | --force)
        OVERWRITE=true
        ;;
    # -t | --tag)
    #     shift
    #     TAG=$1
    #     ;;
    -h | --help)
        usage
        ;;
    *)
        usage
        exit 1
        ;;
    esac
    shift
done

# if [[ $TAG == "" ]]; then
#     echo "You must provide a tag";
#     exit 1;
# fi


for file in .[a-zA-Z]*; do

    # Check if file should be ignored
    if echo "$SKIP_FILES" | grep -qw "$file"; then
        continue
    fi

    src=$(readlink -f $file) # Get full path
    dest="$HOME/$file"

    # If destination file exists and we should not overwrite
    if [ -a "$dest" ] && [[ $OVERWRITE == false ]]; then
        if ! (yes_or_no "File "$dest" already exists. ${redbold}Overwrite?${c}"); then
            continue # skip iteration
        fi
    fi
    # We can safely force
    ln -sf "$src" "$dest" && echo "${G}Success${W}: $dest --> $src"
done;
unset file;
