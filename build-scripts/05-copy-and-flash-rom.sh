#!/bin/bash
die () {
    echo >&2 "$@"
    exit 1
}

# [ "$#" -eq 1 ] || die "1 argument required, $# provided"
# echo $1 | grep -E -q '^[0-9]+$' || die "Numeric argument required, $1 provided"
ssh-keygen -f "/home/flo/.ssh/known_hosts" -R "192.168.1.1"
FILEPATH="/home/flo/beryl/openwrt/bin/targets/mediatek/filogic/openwrt-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin"
FILENAME="openwrt-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin"

scp $FILEPATH root@192.168.1.1:/tmp/

ssh root@192.168.1.1 df -h
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

confirm && ssh root@192.168.1.1 sysupgrade -n -v /tmp/$FILENAME
ssh-keygen -f "/home/flo/.ssh/known_hosts" -R "192.168.1.1"
