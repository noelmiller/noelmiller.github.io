#!/bin/bash
domain="noelmiller.dev"
date=$(date '+%Y-%m-%d %H:%M')
rm -r ./docs
pelican content -s publishconf.py -o ./docs
cp ./CNAME ./docs
git add .
git commit
git push origin main
