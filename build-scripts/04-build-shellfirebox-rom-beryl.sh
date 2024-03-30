#!/bin/bash -v

cd ~/beryl/openwrt

rm -rf files
cp -R ~/beryl/git/shellfirebox-files/files_template files

DATE=`date +%Y-%m`
SECRETS_FILE="box_secrets_$DATE.txt"
ROM_DIR="shellfire-boxes-$DATE"
mkdir ~/beryl/$ROM_DIR

BOX_ID=`ls -1 ~/beryl/$ROM_DIR | wc -l`
# BOX_ID=$(($BOX_ID / 2))
BOX_ID=$(($BOX_ID + 55000))
BOX_ID="sfbox-"$(($BOX_ID + 1))

echo "ROM_DIR=$ROM_DIR"
echo "BOX_ID=$BOX_ID"
echo "SECRETS_FILE=$SECRETS_FILE"



WIRELESS="files/etc/config/wireless"
WPA_KEY=`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-9};echo;`
echo "generated WPA_KEY: $WPA_KEY"
SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`
echo "generated SSID:"
echo $SSID
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
SFBOX_UID="mb97quy46kvuvsq38p7wbah6aqm6gykqnrccbw3g2agdxnkw8qwbqkkaz8a92h5c2ph4w4gcdr3bfasyzpfb243b8spdd6hwx6p7phu9zgq35ng5xmz9x26e4mqnc9d3"
echo "generated UID: $SFBOX_UID"
echo "$SFBOX_UID" > files/etc/sfboxuid

sed -i -- "s/THE_WPA_KEY/$WPA_KEY/g" $WIRELESS
sed -i -- "s/THE_SSID/$SSID/g" $WIRELESS

echo "BOX_ID=$BOX_ID	SSID=$SSID	WPA_KEY=$WPA_KEY	FILENAME_FACTORY=$DEST_FILENAME_FACTORY	FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE	SFBOX_UID=$SFBOX_UID" >> ~/$SECRETS_FILE

# make clean


make -j1 V=s


cp bin/targets/mediatek/filogic/openwrt-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin ~/beryl/$ROM_DIR/$DEST_FILENAME_SYSUPGRADE

echo "generated WPA_KEY: $WPA_KEY"
echo "DEST_FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE"

