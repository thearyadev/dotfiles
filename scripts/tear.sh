#!/bin/bash

if ! command -v jq &> /dev/null; then
   echo "Error: jq is required but not installed"
   exit 1
fi

if ! command -v hyprctl &> /dev/null; then
   echo "Error: hyprctl not found (are you running Hyprland?)"
   exit 1
fi

echo "Monitoring first monitor [0] for tearing..."
echo "Will exit when activelyTearing becomes true"
echo ""

while true; do
   # Get monitor data
   json=$(hyprctl monitors -j 2>/dev/null)
   
   if [ $? -ne 0 ] || [ -z "$json" ]; then
       echo "Error: Failed to fetch monitor data"
       sleep 1
       continue
   fi
   
   # Extract values
   actively_tearing=$(echo "$json" | jq -r '.[0].activelyTearing')
   blocked_by=$(echo "$json" | jq -r '.[0].tearingBlockedBy')
   
   # Display current status (remove 'clear' if you want scrolling history)
   echo "Monitor [0] Tearing Status:"
   echo "  activelyTearing: $actively_tearing"
   echo "  tearingBlockedBy: $blocked_by"
   echo ""
   echo "Waiting for activelyTearing to become true..."
   
   # Exit condition
   if [ "$actively_tearing" = "true" ]; then
       echo ""
       echo ">>> activelyTearing is TRUE! Exiting. <<<"
       exit 0
   fi
   
   sleep 0.5  # Check twice per second
done
