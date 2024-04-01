#!/bin/bash

if [[ -z "$1" ]]; then
  NUM_ROMS_TO_BUILD=1
else
  NUM_ROMS_TO_BUILD=$1
fi

for i in {1..$NUM_ROMS_TO_BUILD}
do
	# Generate the input for rom generation
	DATE=`date +%Y-%m`
	export SECRETS_FILE="box_secrets_$DATE.txt"
	export ROM_DIR="shellfire-boxes-$DATE"
  mkdir $ROMDIR

	export BOX_ID=`ls -1 ~/beryl/$ROM_DIR | wc -l`
	export BOX_ID=$(($BOX_ID / 2))
	export BOX_ID=$(($BOX_ID + 55000))
	export BOX_ID="sfbox-"$(($BOX_ID + 1))

	export WPA_KEY=`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-9};echo;`
	export SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`
	export DEST_FILENAME_SYSUPGRADE="$BOX_ID-sysupgrade.bin"
	export HOUR=`shuf -i 0-23 -n 1`
	export MINUTE=`shuf -i 0-59 -n 1`

	#export SFBOX_UID=`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-128};echo;`
	export SFBOX_UID="mb97quy46kvuvsq38p7wbah6aqm6gykqnrccbw3g2agdxnkw8qwbqkkaz8a92h5c2ph4w4gcdr3bfasyzpfb243b8spdd6hwx6p7phu9zgq35ng5xmz9x26e4mqnc9d3"
	export SSID="Shellfire-Box-"`< /dev/urandom tr -dc abcdefghkmnpqrstuvwxyz23456789 | head -c${1:-5};echo;`

	echo "BOX_ID=$BOX_ID	SSID=$SSID	WPA_KEY=$WPA_KEY	FILENAME_FACTORY=$DEST_FILENAME_FACTORY	FILENAME_SYSUPGRADE=$DEST_FILENAME_SYSUPGRADE	SFBOX_UID=$SFBOX_UID" >> ~/$SECRETS_FILE

	./04-build-shellfirebox-rom-beryl.sh 
done
