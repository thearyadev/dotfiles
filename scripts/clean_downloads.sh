#!/usr/bin/env bash
date=$(date '+%Y-%m-%d')
downloads="/home/arya/Downloads"
dirname=".hist-$date"
mkdir "$downloads/$dirname" 2>/dev/null
mv $downloads/* "$downloads/$dirname" 2>/dev/null
ls

