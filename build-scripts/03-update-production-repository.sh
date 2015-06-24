cd OpenWrt-ImageBuilder-15.05-rc2/packages/luci
../../scripts/ipkg-make-index.sh . > Packages 2>/dev/null
gzip -9c Packages > Packages.gz
rsync -aWz --delete . bettmenn@server1.shellfire.net:/home/bettmenn/shellfirebox-repository


