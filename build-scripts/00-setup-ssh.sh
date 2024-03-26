ssh-keygen -f "/home/flomint/.ssh/known_hosts" -R 10.30.20.115
ssh-keygen -f "/home/flomint/.ssh/known_hosts" -R 10.30.20.1
ssh-keygen -f "/home/flomint/.ssh/known_hosts" -R sf.box

scp -r ~/.ssh/id_rsa.pub root@10.30.20.1:/etc/dropbear/authorized_keys

