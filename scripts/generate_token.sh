#!/usr/bin/env sh
set -e

cleanup() { stty echo 2>/dev/null || true; }
trap cleanup EXIT INT TERM

# Prompt for username
printf "Username: "
read -r USERNAME

# Prompt for API key (silent)
printf "API key: "
stty -echo
read -r APIKEY
cleanup
printf "\n"

# Encode and copy
ENCODED=$(printf "%s" "${USERNAME}:${APIKEY}" | base64 | tr -d '\n')
printf "%s" "$ENCODED" | pbcopy

printf "\nYour encoded token has been copied to the clipboard:\n\n"
printf "%s\n" "$ENCODED"
