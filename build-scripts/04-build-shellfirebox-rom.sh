cd OpenWrt-ImageBuilder-15.05-rc2

rm -rf files
cp -R ~/git/shellfirebox-files/files_template files

BOX_ID=`ls -1 ./shellfire-boxes | wc -l`
BOX_ID=$(($BOX_ID / 2))
BOX_ID="sfbox-"$(($BOX_ID + 1))
echo "BOX_ID=$BOX_ID"


WIRELESS="files/etc/config/wireless"
WPA_KEY=`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-9};echo;`
echo "generated WPA_KEY: $WPA_KEY"
SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`
echo "generated SSID: $SSID"
DEST_FILENAME_FACTORY="$BOX_ID-factory.bin"
DEST_FILENAME_SYSUPGRADE="$BOX_ID-sysupgrade.bin"
echo "DEST_FILENAME_FACTORY=$DEST_FILENAME_FACTORY"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"

HOUR=`shuf -i 0-23 -n 1`
MINUTE=`shuf -i 0-59 -n 1`
echo "Random daily time for update cron will be $HOUR:$MINUTE"
CRONFILE="files/etc/crontabs/root"
sed -i -- "s/THE_HOUR/$HOUR/g" $CRONFILE
sed -i -- "s/THE_MINUTE/$MINUTE/g" $CRONFILE


#SFBOX_UID=`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-128};echo;`
SFBOX_UID="sfbca93e41589dcebec3df0433f52ad0927"
echo "generated UID: $SFBOX_UID"
echo "$SFBOX_UID" > files/etc/sfboxuid

sed -i -- "s/THE_WPA_KEY/$WPA_KEY/g" $WIRELESS
sed -i -- "s/THE_SSID/$SSID/g" $WIRELESS

echo "BOX_ID=$BOX_ID	SSID=$SSID	WPA_KEY=$WPA_KEY	FILENAME_FACTORY=$DEST_FILENAME_FACTORY	FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE	SFBOX_UID=$SFBOX_UID" >> box_secrets.txt

make clean
make image PACKAGES="openvpn-polarssl wget ca-certificates luci luci-i18n-base-de luci-app-shellfirebox luci-i18n-shellfirebox-de luasec luci-lib-json obfsproxy -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/
# make image PACKAGES="openvpn-openssl openssl-util wget ca-certificates luci luci-i18n-base-de luci-app-shellfirebox luci-i18n-shellfirebox-de luasec luci-lib-json obfsproxy -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/


cp bin/ramips/openwrt-15.05-rc2-ramips-mt7620-wt3020-8M-squashfs-sysupgrade.bin shellfire-boxes/$DEST_FILENAME_SYSUPGRADE
cp bin/ramips/openwrt-15.05-rc2-ramips-mt7620-wt3020-8M-squashfs-factory.bin shellfire-boxes/$DEST_FILENAME_FACTORY

echo "generated WPA_KEY: $WPA_KEY"
SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`

echo "DEST_FILENAME_FACTORY=$DEST_FILENAME_FACTORY"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"

