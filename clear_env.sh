#!/bin/bash

# load the repo url u wanna use
repos_file="repos.txt"
readarray -t repos < "$repos_file"

for repo_url in "${repos[@]}"
do
    # Split the repo name 
    IFS='/' read -ra tmp <<< "$repo_url"
    IFS='.' read -a repo <<< "${tmp[4]}"

    # Check if environment already exists
    if conda env list | grep -q "$repo"
    then
        conda env remove --name "$repo"
    fi


done

conda env list