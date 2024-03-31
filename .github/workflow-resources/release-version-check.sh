# assumes $INPUT_VERSION is set to the selected release version
CURRENT_VERSION=$(echo "$(cat DESCRIPTION)" | grep "Version:" | awk '{print $2}')

if [ "$(printf '%s\n' "$INPUT_VERSION" "$CURRENT_VERSION" | sort -V | head -n1)" = "$INPUT_VERSION" ]; then
    echo "::error title=Invalid version::Provided version number must be higher than the current version ($CURRENT_VERSION)."
    exit 1
fi
