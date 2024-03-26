export PATH="~/openwrt-imagebuilder-minibox/staging_dir/host/bin:$PATH"
cd ~/openwrt-imagebuilder-minibox/packages/luci
../../scripts/ipkg-make-index.sh . > Packages 2>/dev/null
gzip -9c Packages > Packages.gz
rsync -aWz --delete . root@server1.shellfire.net:/var/www/shellfire/shellfirebox-repo-test/

# r3VCgC5xp
