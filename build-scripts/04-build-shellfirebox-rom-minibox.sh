<<<<<<< HEAD
#!/bin/bash
=======
#!/bin/bash -v

cd ~/beryl/openwrt

rm -rf files
cp -R ~/git/shellfirebox-files/files_template files

DATE=`date +%Y-%m`
SECRETS_FILE="box_secrets_$DATE.txt"
ROM_DIR="shellfire-boxes-$DATE"
mkdir ~/beryl/$ROM_DIR

BOX_ID=`ls -1 ~/beryl/$ROM_DIR | wc -l`
# BOX_ID=$(($BOX_ID / 2))
BOX_ID=$(($BOX_ID + 55000))
BOX_ID="sfbox-"$(($BOX_ID + 1))
>>>>>>> 54be421 (beryl dev updates)

# Output the generated variables to screen for debug purposes
echo "ROM_DIR=$ROM_DIR"
echo "BOX_ID=$BOX_ID"
echo "generated WPA_KEY: $WPA_KEY"
echo "generated SSID: $SSID"
echo "DEST_FILENAME_FACTORY=$DEST_FILENAME_FACTORY"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"
echo "CRON-SCHEDULE AT: $HOUR:$MINUTE"
echo "SFBOX_UID: $SFBOX_UID"
echo "DEST_FILENAME_FACTORY=$DEST_FILENAME_FACTORY"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"

# Define static variables per hardware type (different for minibox/wt3020)
THE_WAN_IFNAME="eth0"
THE_LAN_IFNAME="eth1"
WIFI_DEVICE_PATH="platform\/qca953x_wmac"
THE_REPO_PATH="https:\/\/www.shellfire.de\/shellfirebox-repo-18.06.4"

# define static variables (same of minibox/wt3020)
WIRELESS="files/etc/config/wireless"
NETWORK="files/etc/config/network"
CRONFILE="files/etc/crontabs/root"
OPKG_REPO_CONF="files/etc/opkg/customfeeds.conf"

# build the rom

# prepare some directories
cd openwrt-imagebuilder
rm -rf files
cp -R ~/git/shellfirebox-files/files_template files
mkdir ~/minibox/$ROM_DIR

# write the sfboxuid file
echo "$SFBOX_UID" > files/etc/sfboxuid

# perform substitutions within the files
# substitutions part 1 - customization for user/specific rom
sed -i -- "s/THE_HOUR/$HOUR/g" $CRONFILE
sed -i -- "s/THE_MINUTE/$MINUTE/g" $CRONFILE
sed -i -- "s/THE_WPA_KEY/$WPA_KEY/g" $WIRELESS
sed -i -- "s/THE_SSID/$SSID/g" $WIRELESS
# substitutions part 1 - customization for hardware
sed -i -- "s/THE_WIFI_DEVICE_PATH/$WIFI_DEVICE_PATH/g" $WIRELESS
sed -i -- "s/THE_WAN_IFNAME/$THE_WAN_IFNAME/g" $NETWORK
sed -i -- "s/THE_LAN_IFNAME/$THE_LAN_IFNAME/g" $NETWORK
sed -i -- "s/THE_REPO_PATH/$THE_REPO_PATH/g" $OPKG_REPO_CONF

# build the image
make -j 5 image PROFILE="minibox-v3" PACKAGES="openvpn-openssl wget ca-certificates luci luci-i18n-base-de luci-i18n-base-en luci-i18n-base-it luci-i18n-base-fr luci-i18n-base-es luci-i18n-base-pt luci-app-shellfirebox luci-i18n-shellfirebox-de luci-i18n-shellfirebox-it luci-i18n-shellfirebox-es luci-i18n-shellfirebox-fr luci-i18n-shellfirebox-pt luci-i18n-shellfirebox-en luasec kmod-wireguard wireguard-tools luci-proto-wireguard luci-lib-json obfsproxy-legacy libustream-openssl ca-bundle logrotate -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/

<<<<<<< HEAD
# copy generated image to target directory
cp bin/targets/ar71xx/generic/openwrt-ar71xx-generic-minibox-v3-squashfs-sysupgrade.bin ~/minibox/$ROM_DIR/$DEST_FILENAME_SYSUPGRADE
#cp bin/targets/ar71xx/generic/openwrt-ar71xx-generic-minibox-v3-squashfs-factory.bin ~/minibox/$ROM_DIR/$DEST_FILENAME_FACTORY
=======
# make clean

# make image PROFILE="minibox-v3" PACKAGES="openvpn-openssl wget ca-certificates luci luci-i18n-base-de luci-i18n-base-en luci-i18n-base-it luci-i18n-base-fr luci-i18n-base-es luci-i18n-base-pt luci-app-shellfirebox luci-i18n-shellfirebox-de luci-i18n-shellfirebox-it luci-i18n-shellfirebox-es luci-i18n-shellfirebox-fr luci-i18n-shellfirebox-pt luci-i18n-shellfirebox-en luasec kmod-wireguard wireguard-tools luci-proto-wireguard luci-lib-json -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/
make -j8



# current stuff
#make image PROFILE="wt3020-8M" PACKAGES="openvpn-openssl wget ca-certificates luci luci-i18n-base-de luci luci-i18n-base-en luci luci-i18n-base-it luci luci-i18n-base-fr luci luci-i18n-base-es luci luci-i18n-base-pt luci-app-shellfirebox luci-i18n-shellfirebox-de luci-i18n-shellfirebox-it luci-i18n-shellfirebox-es luci-i18n-shellfirebox-fr luci-i18n-shellfirebox-pt luci-i18n-shellfirebox-en luasec kmod-wireguard wireguard-tools luci-proto-wireguard luci-lib-json -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/



# old stuff
#make image PROFILE="wt3020-8M" PACKAGES="openvpn-openssl wget ca-certificates luci luci-i18n-base-de luci-app-shellfirebox luci-i18n-shellfirebox-de luasec luci-lib-json obfsproxy-legacy luci-app-wireguard -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/
#make image PACKAGES="openvpn-polarssl wget ca-certificates luci luci-i18n-base-de luci-app-shellfirebox luci-i18n-shellfirebox-de luci-i18n-shellfirebox-de luasec luci-lib-json obfsproxy-legacy -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/
# make image PACKAGES="openvpn-openssl openssl-util wget ca-certificates luci luci-i18n-base-de luci-app-shellfirebox luci-i18n-shellfirebox-de luasec luci-lib-json obfsproxy -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/


cp bin/targets/mediatek/filogic/openwrt-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin ~/$ROM_DIR/$DEST_FILENAME_SYSUPGRADE

echo "generated WPA_KEY: $WPA_KEY"
SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`

echo "DEST_FILENAME_FACTORY=$DEST_FILENAME_FACTORY"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"
>>>>>>> 54be421 (beryl dev updates)

echo "done"
