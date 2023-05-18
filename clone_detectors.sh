#!/bin/bash

# load the repo url u wanna use
repos_file="repos.txt"
readarray -t repos < "$repos_file"


for repo_url in "${repos[@]}"
do
    # clone repo
    git clone "$repo_url"
    echo "[CLONE THE REPO] $repo_url"
done
