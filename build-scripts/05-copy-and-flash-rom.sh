#!/bin/bash
die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"
echo $1 | grep -E -q '^[0-9]+$' || die "Numeric argument required, $1 provided"

FILENAME="sfbox-$1-sysupgrade.bin"
FILEPATH="OpenWrt-ImageBuilder-15.05-rc2/shellfire-boxes/$FILENAME"

scp $FILEPATH root@10.30.20.1:/tmp/

ssh root@10.30.20.1 df -h
ls -lah $FILEPATH
confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# confirm && 
ssh root@10.30.20.1 sysupgrade -n -v /tmp/$FILENAME
