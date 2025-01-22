#!/bin/bash
# This script is used to generate a report of all repositories where there are new commits on the default branch and a release has not been created. 
# It also shows the last release date and the number of days since the last release.
#
# Run the script like this:
#    source ./check-for-releases.sh newfold-labs
#
# You change the org name if needed. If the org name is not provided, it will default to newfold-labs. 
# Pass an optional second parameter to set the limit on the number of repositories fetched (default is 150).

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

        # Get the latest release date
        release_date=$(gh release view --repo "$repo" --json publishedAt -q '.publishedAt' | cut -d'T' -f1)
        
        # Calculate days since last release in a cross-platform way
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            release_ts=$(date -j -f "%Y-%m-%d" "$release_date" "+%s")
            current_ts=$(date "+%s")
        else
            # Linux
            release_ts=$(date -d "$release_date" "+%s")
            current_ts=$(date "+%s")
        fi
        days_since=$(( (current_ts - release_ts) / 86400 ))

        # Compare the latest release tag with the main branch
        commits=$(gh api "/repos/$repo/compare/$latest_tag...$default_branch" | jq '.commits | length')
        if [ "$commits" -eq 0 ]; then
            printf " ${GREEN}No updates${NC} (Last release: $release_date, $days_since days ago)\n"
        else
            printf " ${RED}Needs update${NC} - $commits new commits since last release ($release_date, $days_since days ago)\n"
        fi
    fi
done