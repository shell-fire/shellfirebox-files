# scp -r /home/flo/linked/www/luci-static/shellfirebox/* root@10.30.20.1:/www/luci-static/shellfirebox/
scp /home/flo/linked/usr/lib/lua/luci/shellfirebox.lua root@10.30.20.1:/usr/lib/lua/luci/shellfirebox.lua

scp /home/flo/linked/usr/lib/lua/luci/controller/shellfirebox.lua root@10.30.20.1:/usr/lib/lua/luci/controller/shellfirebox.lua
scp /home/flo/linked/usr/lib/lua/luci/controller/admin/status.lua root@10.30.20.1:/usr/lib/lua/luci/controller/admin/
scp -r /home/flo/linked/usr/lib/lua/luci/shellfirebox/* root@10.30.20.1:/usr/lib/lua/luci/shellfirebox/
scp -r /home/flo/linked/usr/lib/lua/luci/view/shellfirebox/* root@10.30.20.1:/usr/lib/lua/luci/view/shellfirebox/
scp -r /home/flo/linked/usr/lib/lua/luci/view/themes/shellfirebox/* root@10.30.20.1:/usr/lib/lua/luci/view/themes/shellfirebox/
scp /home/flo/linked/usr/lib/lua/luci/debugger.lua root@10.30.20.1:/usr/lib/lua/luci/debugger.lua

scp /home/flo/linked/usr/lib/lua/luci/fs.lua root@10.30.20.1:/usr/lib/lua/luci/fs.lua
scp /home/flo/linked/usr/lib/lua/luci/controller/admin/index.lua root@10.30.20.1:/usr/lib/lua/luci/controller/admin/index.lua
scp /home/flo/linked/usr/lib/lua/luci/view/themes/bootstrap/* root@10.30.20.1:/usr/lib/lua/luci/view/themes/bootstrap/

scp /home/flo/linked/usr/lib/lua/luci/dispatcher.lua root@10.30.20.1:/usr/lib/lua/luci/
scp /home/flo/linked/usr/lib/lua/luci/sys.lua root@10.30.20.1:/usr/lib/lua/luci/


ssh root@10.30.20.1 rm -rf /tmp/luci-*
