#!/usr/bin/env bash
# Helper script to enable the performance gov with proton or others
if ! command -v powerprofilesctl &>/dev/null; then
    echo "Error: powerprofilesctl not found" >&2
    exit  1
fi


/home/arya/.config/hypr/gamemode.sh

# Don't fail if the CPU driver doesn't support performance power profile
if ! powerprofilesctl list | grep -q 'performance:'; then
    exec "$@"
fi

# Set performance governors, as long the game is launched
if [ -n "$GAME_PERFORMANCE_SCREENSAVER_ON" ]; then
    exec powerprofilesctl launch -p performance \
        -r "gamewrapper.sh" -- "$@"
else
    exec systemd-inhibit --why "gamewrapper.sh" powerprofilesctl launch \
        -p performance -r "gamewrapper.sh" -- "$@"
fi


/home/arya/.config/hypr/gamemode.sh
