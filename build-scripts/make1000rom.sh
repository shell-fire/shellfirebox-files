#!/bin/bash
for i in {1..1000}
do
	# Generate the input for rom generation
	DATE=`date +%Y-%m`
	export SECRETS_FILE="box_secrets_$DATE.txt"
	export ROM_DIR="shellfire-boxes-$DATE"

	export BOX_ID=`ls -1 ~/wt3020h-18.06.4/$ROM_DIR | wc -l`
	export BOX_ID=$(($BOX_ID / 2))
	export BOX_ID=$(($BOX_ID + 55000))
	export BOX_ID="sfbox-"$(($BOX_ID + 1))

	export WPA_KEY=`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-9};echo;`
	export SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`
	export DEST_FILENAME_FACTORY="$BOX_ID-factory.bin"
	export DEST_FILENAME_SYSUPGRADE="$BOX_ID-sysupgrade.bin"
	export HOUR=`shuf -i 0-23 -n 1`
	export MINUTE=`shuf -i 0-59 -n 1`

	#export SFBOX_UID=`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-128};echo;`
	export SFBOX_UID="axdg3s9xc9bm4pxr6kmyax3yrwe4z9vx2tk7w2dr2n7dcekzp7n9kce3bnwtxd682efg353csn6u8cm5d6hwvu9kq9mfqp8bt2nqtwzrkyvnxm5p8cwnrne6su8zchfa"

	export SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`

	echo "BOX_ID=$BOX_ID	SSID=$SSID	WPA_KEY=$WPA_KEY	FILENAME_FACTORY=$DEST_FILENAME_FACTORY	FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE	SFBOX_UID=$SFBOX_UID" >> ~/$SECRETS_FILE

	./04-build-shellfirebox-rom.sh 
done
