cd openwrt
./scripts/feeds update luci
make package/luci-app-shellfirebox/compile V=s
rm ../OpenWrt-ImageBuilder-15.05-rc2/packages/luci/luci-*-shellfirebox*

cp bin/ramips/packages/luci/luci-*-shellfirebox* ../OpenWrt-ImageBuilder-15.05-rc2/packages/luci/


