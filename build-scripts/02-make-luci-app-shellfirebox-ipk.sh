#!/bin/bash -v

cd /home/flo/beryl/git/luci
git pull

cd /home/flomint/git/shellfirebox-files
git pull


cd ~/openwrt-sdk

#### Important installation advice: ####
# for newly downloaded openwrt-sdk, do
# vi feeds.conf.default
# replace luci github url by local path:
# #src-git luci https://git.openwrt.org/project/luci.git^b07cf9dcfc37e021e5619a41c847e63afbd5d34a
# src-cpy luci /home/flo/beryl/git/luci/

# ./scripts/feeds update -a
# ./scripts/feeds install -a
# this makes luci-app-shellfirebox available in make menuconfig
# ./scripts/feeds install luci-app-shellfirebox

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
make package/luci-app-shellfirebox/compile V=s -j8
rm ../openwrt-imagebuilder-minibox/packages/luci/luci-*-shellfirebox*
#rm ../openwrt-imagebuilder-minibox/packages/luci/*luci*

cp bin/packages/mipsel_24kc/luci/luci-*-shellfirebox* ../openwrt-imagebuilder-minibox/packages/luci/
#cp bin/packages/mipsel_24kc/luci/*luci* ../openwrt-imagebuilder-minibox/packages/luci/


