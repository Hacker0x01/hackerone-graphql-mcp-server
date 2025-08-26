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
# Copy to clipboard (macOS: pbcopy, Linux: xclip/xsel)
if command -v pbcopy >/dev/null 2>&1; then
    printf "%s" "$ENCODED" | pbcopy
    CLIPBOARD_MSG="Your encoded token has been copied to the clipboard."
elif command -v xclip >/dev/null 2>&1; then
    printf "%s" "$ENCODED" | xclip -selection clipboard
    CLIPBOARD_MSG="Your encoded token has been copied to the clipboard."
elif command -v xsel >/dev/null 2>&1; then
    printf "%s" "$ENCODED" | xsel --clipboard --input
    CLIPBOARD_MSG="Your encoded token has been copied to the clipboard."
else
    CLIPBOARD_MSG="Could not copy to clipboard: no pbcopy, xclip, or xsel found."
fi

printf "\n%s\n\n" "$CLIPBOARD_MSG"
printf "%s\n" "$ENCODED"
