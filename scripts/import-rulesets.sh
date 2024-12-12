#!/bin/bash

RULESETS_PATH='./rulesets/'
PAGE=1
# Set organization name
ORG_NAME=${1:-"newfold-labs"}

while true; do
    repos=$(gh api "users/$ORG_NAME/repos?per_page=20&page=$PAGE" --jq '.[].name') 
    if [ -z "$repos" ]; then 
        break 
    fi 
    
    for repo in $repos; do 
        echo "Processing repository: $repo"

        rulesets=$(gh api /repos/$ORG_NAME/$repo/rulesets )

        for file in "$RULESETS_PATH"/*.json; do
            if [ -f "$file" ]; then
                
                name=$(jq -c '.name' "$file")
                id=$( echo "$rulesets" | jq ".[] | select(.name == $name) | .id" )

                if [ -z "$id" ]; then
                    gh api --method POST -H "Accept: application/vnd.github+json" /repos/$ORG_NAME/$repo/rulesets --input "$file" --silent
                else
                    gh api --method PUT -H "Accept: application/vnd.github+json" /repos/$ORG_NAME/$repo/rulesets/$id --input "$file" --silent
                fi
            fi
        done
    done

    PAGE=$((PAGE + 1))
done
