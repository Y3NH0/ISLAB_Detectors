#!/bin/bash

# load the repo url u wanna use
repos_file="repos.txt"
readarray -t repos < "$repos_file"

for repo_url in "${repos[@]}"
do
    # Split the repo name -> $reoo
    IFS='/' read -ra tmp <<< "$repo_url"
    IFS='.' read -a repo <<< "${tmp[4]}"

    # rm -rf the repo
    rm -rf ${repo[0]}
done

ls -al