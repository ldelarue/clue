#!/bin/bash

# Generate a CalVer version based on the current date.
# The version format is YY.MM.PATCH, where:
# - YY is the last two digits of the current year
# - MM is the current month (01-12)
# - PATCH is incremented for each new version in the same month
# It creates a file named .calver in the current directory
# and updates it with the new version.

set -euo pipefail

# File to store the version
VERSION_FILE=".calver"

# Get current date components
CURRENT_YEAR=${1:-$(date +"%Y")}
CURRENT_MONTH=${2:-$(date +"%m")}

# Extract last two digits of year
CALVER_YEAR=${CURRENT_YEAR: -2}

# Helper function to validate version format
validate_version() {
    local version=$1
    [[ $version =~ ^[0-9]{2}\.[0-9]{2}\.[0-9]+$ ]] && return 0 || return 1
}

# Function to initialize new version
init_version() {
    echo "${CALVER_YEAR}.${CURRENT_MONTH}.0" > "$VERSION_FILE"
    chmod 644 "$VERSION_FILE"
}

# Function to update version
update_version() {
    if [ ! -f "$VERSION_FILE" ]; then
        init_version
        return
    fi
    
    CURRENT_VERSION=$(cat "$VERSION_FILE")
    
    if ! validate_version "$CURRENT_VERSION"; then
        echo "Error: Invalid version format in $VERSION_FILE" >&2
        exit 1
    fi
    
    # Extract components
    VERSION_YEAR=$(cut -d '.' -f 1 <<< "$CURRENT_VERSION")
    VERSION_MONTH=$(cut -d '.' -f 2 <<< "$CURRENT_VERSION")
    VERSION_PATCH=$(cut -d '.' -f 3 <<< "$CURRENT_VERSION")
    
    # Check if we're in the same month/year
    if [ "$VERSION_YEAR.$VERSION_MONTH" = "${CALVER_YEAR}.${CURRENT_MONTH}" ]; then
        # Increment patch level
        NEW_PATCH=$((VERSION_PATCH + 1))
        echo "${CALVER_YEAR}.${CURRENT_MONTH}.${NEW_PATCH}" > "$VERSION_FILE"
    else
        # New month/year, reset patch level
        echo "${CALVER_YEAR}.${CURRENT_MONTH}.0" > "$VERSION_FILE"
    fi
}

update_version

# Print the new version
cat "$VERSION_FILE"