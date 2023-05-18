#!/bin/bash

install_requirements() {
    file="$1"

    while read -r line; do
        conda install -y $line

        # $? == return val of "conda install", successfully installed if $? == 0
        if [ $? -ne 0 ]; then
            # use pip if conda doesnt work
            pip install $line
        fi
    done < "$file"
}


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
        echo "$repo's environment already exists"
        continue
    fi

    # create the envr
    env_name=$repo
    conda create -y -n $env_name
    source ~/.bashrc
    source activate
    conda activate $env_name
    install_requirements requirements.txt
    conda create -y -n ${repo[0]}

    # according the requirements.txt, install the package 
    cd $repo
    install_requirements requirements.txt
done