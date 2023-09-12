#!/bin/bash
domain="noelmiller.dev"
date=$(date '+%Y-%m-%d %H:%M')
rm -r ./docs
pelican content -o ./docs
cp ./CNAME ./docs
git add .
git commit -m "deploy site $(date '+%Y-%m-%d %H:%M')"
git push origin main
