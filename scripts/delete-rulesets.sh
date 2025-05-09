#!/bin/bash

DELETED_PATH='./deleted/'
PAGE=1
# Set organization name
ORG_NAME=${1:-"newfold-labs"}

if [ -z "$(ls -A "$DELETED_PATH")" ]; then
    echo "No deleted rulesets to process."
else
    while true; do
        repos=$(gh api "users/$ORG_NAME/repos?per_page=20&page=$PAGE" --jq '.[].name') 
        if [ -z "$repos" ]; then 
            break 
        fi 
        
        for repo in $repos; do 
            echo "Processing repository: $repo"

            rulesets=$(gh api /repos/$ORG_NAME/$repo/rulesets )

            for file in "$DELETED_PATH"/*.json; do
                if [ -f "$file" ]; then
                    
                    name=$(jq -c '.name' "$file")
                    id=$( echo "$rulesets" | jq ".[] | select(.name == $name) | .id" )

                    if [ -z "$id" ]; then
                        continue
                    fi

                    gh api --method DELETE -H "Accept: application/vnd.github+json" /repos/OWNER/REPO/rulesets/$id --silent
                fi
            done
        done

        PAGE=$((PAGE + 1))
    done
fi
