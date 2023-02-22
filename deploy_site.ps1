$domain = "noelmiller.dev"
$current_date = Get-Date -Format "yyyy-MM-dd HH:mm"
Remove-Item -Recurse .\docs
pelican content -o .\docs
Copy-Item .\CNAME .\docs
git add .
git commit -m "deploy site $current_date"
git push origin main
