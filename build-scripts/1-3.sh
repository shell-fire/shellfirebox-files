#!/bin/bash

./01-copy-from-dev-to-luci-app-shellfirebox.sh 
./02-make-luci-app-shellfirebox-ipk.sh
./03-update-production-repository.sh

