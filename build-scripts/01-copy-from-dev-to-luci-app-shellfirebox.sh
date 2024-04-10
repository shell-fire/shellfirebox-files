# dont update config normally
# scp root@10.30.20.1:/etc/config/shellfirebox /home/flomint/git/shellfirebox-files/files_template/etc/config/
# scp root@10.30.20.1:/etc/config/network /home/flomint/git/shellfirebox-files/files_template/etc/config/
# scp root@10.30.20.1:/etc/config/firewall /home/flomint/git/shellfirebox-files/files_template/etc/config/


#scp -r root@10.30.20.1:/www/luci-static/shellfirebox/* /home/flomint/git/luci/applications/luci-app-shellfirebox/htdocs/luci-static/shellfirebox/
#scp root@10.30.20.1:/usr/lib/lua/luci/controller/shellfirebox.lua /home/flomint/git/luci/applications/luci-app-shellfirebox/luasrc/controller
#scp -r root@10.30.20.1:/usr/lib/lua/luci/shellfirebox/* /home/flomint/git/luci/applications/luci-app-shellfirebox/luasrc/shellfirebox/
#scp -r root@10.30.20.1:/usr/lib/lua/luci/view/shellfirebox/* /home/flomint/git/luci/applications/luci-app-shellfirebox/luasrc/view/shellfirebox/
#scp -r root@10.30.20.1:/usr/lib/lua/luci/view/themes/shellfirebox/* /home/flomint/git/luci/applications/luci-app-shellfirebox/luasrc/view/themes/shellfirebox/
#scp root@10.30.20.1:/usr/lib/lua/luci/debugger.lua /home/flomint/git/luci/applications/luci-app-shellfirebox/luasrc/debugger.lua
#scp root@10.30.20.1:/usr/lib/lua/luci/shellfirebox.lua /home/flomint/git/luci/applications/luci-app-shellfirebox/luasrc/shellfirebox.lua
#scp root@10.30.20.1:/usr/lib/lua/luci/fs.lua /home/flomint/git/luci/applications/luci-app-shellfirebox/luasrc/fs.lua

#scp root@10.30.20.1:/usr/lib/lua/luci/view/themes/bootstrap/* /home/flomint/git/shellfirebox-files/files_template/usr/lib/lua/luci/view/themes/bootstrap/
#scp root@10.30.20.1:/usr/lib/lua/luci/controller/admin/index.lua /home/flomint/git/shellfirebox-files/files_template/usr/lib/lua/luci/controller/admin/index.lua
#scp root@10.30.20.1:/usr/lib/lua/luci/dispatcher.lua /home/flomint/git/shellfirebox-files/files_template/usr/lib/lua/luci/
#scp root@10.30.20.1:/usr/lib/lua/luci/sys.lua /home/flomint/git/shellfirebox-files/files_template/usr/lib/lua/luci/
#scp root@10.30.20.1:/usr/lib/lua/luci/model/cbi/admin_system/admin.lua /home/flomint/git/shellfirebox-files/files_template/usr/lib/lua/luci/model/cbi/admin_system/admin.lua
scp -r /home/flo/beryl/git/luci/applications/luci-app-shellfirebox/htdocs/luci-static/* root@10.30.20.1:/www/luci-static/
scp -r /home/flo/beryl/git/luci/applications/luci-app-shellfirebox/root/usr/* root@10.30.20.1:/usr/


#/home/flo/beryl/git/luci/build/i18n-scan.pl /home/flo/beryl/git/luci/applications/luci-app-shellfirebox/ > /home/flo/beryl/git/luci/applications/luci-app-shellfirebox/po/templates/shellfirebox.pot

#cd /home/flomint/git/luci
#git add .
#git commit -a -m "further dev updates"
#git push


#cd /home/flomint/git/shellfirebox-files
#git add .
#git commit -a -m "further dev updates"
#git push

