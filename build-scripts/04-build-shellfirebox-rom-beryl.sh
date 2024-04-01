#!/bin/bash -v

# Output the generated variables to screen for debug purposes
echo "ROM_DIR=$ROM_DIR"
echo "BOX_ID=$BOX_ID"
echo "generated WPA_KEY: $WPA_KEY"
echo "generated SSID: $SSID"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"
echo "CRON-SCHEDULE AT: $HOUR:$MINUTE"
echo "SFBOX_UID: $SFBOX_UID"
echo "DEST_FILENAME_FACTORY=$DEST_FILENAME_FACTORY"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"

# Static variables
WIRELESS="files/etc/config/wireless"
NETWORK="files/etc/config/network"
CRONFILE="files/etc/crontabs/root"
OPKG_REPO_CONF="files/etc/opkg/customfeeds.conf"
THE_REPO_PATH="https:\/\/www.shellfire.de\/shellfirebox-repo-beryl-23.05.3"

cd ~/beryl/openwrt
rm -rf files
cp -R ~/beryl/git/shellfirebox-files/files_template files

# perform substitutions within the files
# substitutions part 1 - customization for user/specific rom
sed -i -- "s/THE_HOUR/$HOUR/g" $CRONFILE
Sat Mar 30 21:50:26 2024 daemon.info dnsmasq[1]: using only locally-known addresses for local
sed -i -- "s/THE_MINUTE/$MINUTE/g" $CRONFILE
sed -i -- "s/THE_WPA_KEY/$WPA_KEY/g" $WIRELESS
sed -i -- "s/THE_SSID/$SSID/g" $WIRELESS
sed -i -- "s/THE_REPO_PATH/$THE_REPO_PATH/g" $OPKG_REPO_CONF

# write the sfboxuid file
echo "$SFBOX_UID" > files/etc/sfboxuid


# ./scripts/feeds update luci
# make package/luci-app-shellfirebox/compile V=s -j8
make -j8


cp bin/targets/mediatek/filogic/openwrt-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin ~/beryl/$ROM_DIR/$DEST_FILENAME_SYSUPGRADE
cp bin/targets/mediatek/filogic/openwrt-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin /media/sf_vbox_shared/
echo "done"

