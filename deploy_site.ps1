$domain = "noelmiller.dev"
pelican content -o .\docs -s .\publishconf.py
Copy-Item .\CNAME .\docs
git add .
git commit 
git push origin main
