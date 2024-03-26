#!/bin/bash -v

cd /home/flomint/git/luci
git pull

cd /home/flomint/git/shellfirebox-files
git pull


cd ~/openwrt-sdk

#### Important installation advice: ####
# for newly downloaded openwrt-sdk, do
# ./scripts/feeds update
# once without the defined "luci". after that, as we only expect the luci package to change, the following line is sufficient.

./scripts/feeds update luci

## maybe this can also be run in case you get the message that no makefile for luci-app-shellfirebox can be found:
# cat feeds/*.tmp/.packageinfo >> tmp/.packageinfo


#### Important installation advice: ####
# for newly downloaded openwrt-sdk, do
# ~/openwrt-sdk $ make -j4
# without specifying the package, which we do later to speed up things.
# make package/luci-proto-wireguard/compile V=s j=4
#make package/luci/compile V=s -j5
make package/luci-app-shellfirebox/compile V=s -j5
rm ../openwrt-imagebuilder-minibox/packages/luci/luci-*-shellfirebox*
#rm ../openwrt-imagebuilder-minibox/packages/luci/*luci*

cp bin/packages/mipsel_24kc/luci/luci-*-shellfirebox* ../openwrt-imagebuilder-minibox/packages/luci/
#cp bin/packages/mipsel_24kc/luci/*luci* ../openwrt-imagebuilder-minibox/packages/luci/


