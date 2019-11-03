#!/bin/sh

uci batch <<-EOF
	# set luci theme to Shellfire Box non-advanced/regular mode
	set luci.main.mediaurlbase=/luci-static/shellfirebox
	commit luci
	# set hostname to ShellfireBox
	set system.@system[0].hostname=ShellfireBox
	commit system
EOF

# update hostname to ShellfireBox for immediate effect
echo $(uci get system.@system[0].hostname) > /proc/sys/kernel/hostname


# enable updater cronjob
/etc/init.d/cron enable
/etc/init.d/cron start
/usr/bin/crontab /etc/crontabs/root

# disable dropbear by default
/etc/init.d/dropbear disable

# create link (hash) for shellfire-ca.crt
# hash has been created before with command 
# HASH=`openssl x509 -hash -noout -in members.dyndns.org.cer`.0
# see http://wiki.openwrt.org/doc/howto/wget-ssl-certs
# (needs openssl-util which we do not need to install if hashed upfront)
ln -s /etc/ssl/certs/shellfire-ca.crt /etc/ssl/certs/2cd70dd3.0

