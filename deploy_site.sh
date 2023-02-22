#!/bin/bash
domain="noelmiller.dev"
rm -r ./output
pelican content
ghp-import -c $domain ./output -b gh-pages
git push origin gh-pages
