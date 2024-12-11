#!/bin/bash
# This script is used to generate a report of all repositories where there are new commits on the default branch and a release has not been created.
#
# Run the script like this:
#    source ./check-for-releases.sh newfold-labs
#
# You change the org name if needed. If the org name is not provided, it will default to newfold-labs. 
# Pass an optional second parameter to set the limit on the number of repositories fetched.

# Set organization name
ORG_NAME=${1:-"newfold-labs"}

LIMIT=${2:-150}

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

# List all repositories in the organization
gh repo list $ORG_NAME --limit $LIMIT | while read -r repo _; do
    # Extract and align the output
    printf "%-50s" "$repo:"
    
    # Get the latest tag from the repository
    latest_tag=$(gh release view --repo "$repo" --json tagName -q '.tagName' 2>/dev/null)

    # Get the default branch name
    default_branch=$(gh repo view "$repo" --json defaultBranchRef -q '.defaultBranchRef.name')
    
    if [ -z "$latest_tag" ]; then
        printf " No releases found\n"
    else
        # Compare the latest release tag with the main branch
        commits=$(gh api "/repos/$repo/compare/$latest_tag...$default_branch" | jq '.commits | length')
        if [ "$commits" -eq 0 ]; then
            printf " ${GREEN}No updates${NC}\n"
        else
            printf " ${RED}Needs update${NC} - $commits new commits since the last release\n"
        fi
    fi
done