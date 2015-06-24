# dont update config normally
# cp /home/flo/linked/etc/config/shellfirebox /home/flo/git/luci/applications/luci-app-shellfirebox/root/etc/config/

cp -R /home/flo/linked/www/luci-static/shellfirebox/* /home/flo/git/luci/applications/luci-app-shellfirebox/htdocs/luci-static/shellfirebox/
cp /home/flo/linked/usr/lib/lua/luci/controller/shellfirebox.lua /home/flo/git/luci/applications/luci-app-shellfirebox/luasrc/controller
cp -R /home/flo/linked/usr/lib/lua/luci/shellfirebox/* /home/flo/git/luci/applications/luci-app-shellfirebox/luasrc/shellfirebox/
cp -R /home/flo/linked/usr/lib/lua/luci/view/shellfirebox/* /home/flo/git/luci/applications/luci-app-shellfirebox/luasrc/view/shellfirebox/
cp -R /home/flo/linked/usr/lib/lua/luci/view/themes/shellfirebox/* /home/flo/git/luci/applications/luci-app-shellfirebox/luasrc/view/themes/shellfirebox/
cp /home/flo/linked/usr/lib/lua/luci/debugger.lua /home/flo/git/luci/applications/luci-app-shellfirebox/luasrc/debugger.lua
cp /home/flo/linked/usr/lib/lua/luci/shellfirebox.lua /home/flo/git/luci/applications/luci-app-shellfirebox/luasrc/shellfirebox.lua
cp /home/flo/linked/usr/lib/lua/luci/fs.lua /home/flo/git/luci/applications/luci-app-shellfirebox/luasrc/fs.lua

cp /home/flo/linked/usr/lib/lua/luci/view/themes/bootstrap/* /home/flo/OpenWrt-ImageBuilder-15.05-rc2/files_template/usr/lib/lua/luci/view/themes/bootstrap/
cp /home/flo/linked/usr/lib/lua/luci/controller/admin/index.lua /home/flo/OpenWrt-ImageBuilder-15.05-rc2/files_template/usr/lib/lua/luci/controller/admin/index.lua
cp /home/flo/linked/usr/lib/lua/luci/dispatcher.lua /home/flo/OpenWrt-ImageBuilder-15.05-rc2/files_template/usr/lib/lua/luci/
cp /home/flo/linked/usr/lib/lua/luci/sys.lua /home/flo/OpenWrt-ImageBuilder-15.05-rc2/files_template/usr/lib/lua/luci/



cd /home/flo/git/luci
git add .
git commit -a -m "further dev updates"
git push


cd /home/flo/git/shellfirebox-files
git add .
git commit -a -m "further dev updates"
git push

