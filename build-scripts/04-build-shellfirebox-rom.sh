#!/bin/bash -v

cd openwrt-imagebuilder

rm -rf files
cp -R ~/git/shellfirebox-files/files_template files

DATE=`date +%Y-%m`
SECRETS_FILE="box_secrets_$DATE.txt"
ROM_DIR="shellfire-boxes-$DATE"
mkdir ~/minibox/$ROM_DIR

BOX_ID=`ls -1 ~/minibox/$ROM_DIR | wc -l`
BOX_ID=$(($BOX_ID / 2))
BOX_ID=$(($BOX_ID + 55000))
BOX_ID="sfbox-"$(($BOX_ID + 1))

echo "ROM_DIR=$ROM_DIR"
echo "BOX_ID=$BOX_ID"
echo "SECRETS_FILE=$SECRETS_FILE"



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


SFBOX_UID=`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-128};echo;`
#SFBOX_UID="axdg3s9xc9bm4pxr6kmyax3yrwe4z9vx2tk7w2dr2n7dcekzp7n9kce3bnwtxd682efg353csn6u8cm5d6hwvu9kq9mfqp8bt2nqtwzrkyvnxm5p8cwnrne6su8zchfa"
echo "generated UID: $SFBOX_UID"
echo "$SFBOX_UID" > files/etc/sfboxuid

sed -i -- "s/THE_WPA_KEY/$WPA_KEY/g" $WIRELESS
sed -i -- "s/THE_SSID/$SSID/g" $WIRELESS

echo "BOX_ID=$BOX_ID	SSID=$SSID	WPA_KEY=$WPA_KEY	FILENAME_FACTORY=$DEST_FILENAME_FACTORY	FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE	SFBOX_UID=$SFBOX_UID" >> ~/$SECRETS_FILE

# make clean

make image PROFILE="minibox-v3" PACKAGES="openvpn-openssl wget ca-certificates luci luci-i18n-base-de luci-i18n-base-en luci-i18n-base-it luci-i18n-base-fr luci-i18n-base-es luci-i18n-base-pt luci-app-shellfirebox luci-i18n-shellfirebox-de luci-i18n-shellfirebox-it luci-i18n-shellfirebox-es luci-i18n-shellfirebox-fr luci-i18n-shellfirebox-pt luci-i18n-shellfirebox-en luasec kmod-wireguard wireguard-tools luci-proto-wireguard luci-lib-json obfsproxy-legacy libustream-openssl ca-bundle logrotate -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/
#make -j4



# current stuff
#make image PROFILE="wt3020-8M" PACKAGES="openvpn-openssl wget ca-certificates luci luci-i18n-base-de luci luci-i18n-base-en luci luci-i18n-base-it luci luci-i18n-base-fr luci luci-i18n-base-es luci luci-i18n-base-pt luci-app-shellfirebox luci-i18n-shellfirebox-de luci-i18n-shellfirebox-it luci-i18n-shellfirebox-es luci-i18n-shellfirebox-fr luci-i18n-shellfirebox-pt luci-i18n-shellfirebox-en luasec kmod-wireguard wireguard-tools luci-proto-wireguard luci-lib-json obfsproxy-legacy-ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/



# old stuff
#make image PROFILE="wt3020-8M" PACKAGES="openvpn-openssl wget ca-certificates luci luci-i18n-base-de luci-app-shellfirebox luci-i18n-shellfirebox-de luasec luci-lib-json obfsproxy-legacy luci-app-wireguard -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/
#make image PACKAGES="openvpn-polarssl wget ca-certificates luci luci-i18n-base-de luci-app-shellfirebox luci-i18n-shellfirebox-de luci-i18n-shellfirebox-de luasec luci-lib-json obfsproxy-legacy -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/
# make image PACKAGES="openvpn-openssl openssl-util wget ca-certificates luci luci-i18n-base-de luci-app-shellfirebox luci-i18n-shellfirebox-de luasec luci-lib-json obfsproxy -ppp -ppp-mod-pppoe -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-ledtrig-usbdev" FILES=files/


cp bin/targets/ar71xx/generic/openwrt-ar71xx-generic-minibox-v3-squashfs-sysupgrade.bin ~/minibox/$ROM_DIR/$DEST_FILENAME_SYSUPGRADE
cp bin/targets/ar71xx/generic/openwrt-ar71xx-generic-minibox-v3-squashfs-factory.bin ~/minibox/$ROM_DIR/$DEST_FILENAME_FACTORY


echo "generated WPA_KEY: $WPA_KEY"
SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`

echo "DEST_FILENAME_FACTORY=$DEST_FILENAME_FACTORY"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"
