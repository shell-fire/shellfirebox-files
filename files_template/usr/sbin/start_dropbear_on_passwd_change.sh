#!/bin/sh

echo "[start_dropbear_on_passwd_change.sh] starting. waiting until passwd is changed for root, start dropbear only then"

# Directory containing the shadow file
SHADOW_DIR=/etc

# Function to check if root has a password set
check_root_passwd_set() {
    # Extract the password hash field for the root user
    local password_hash=$(awk -F: '/^root:/ {print $2}' $SHADOW_DIR/shadow)
    
    # Check if the password hash field is non-empty and does not indicate a locked account
    if [ -n "$password_hash" ] && [ "$password_hash" != "!" ] && [ "$password_hash" != "*" ]; then
        return 0 # Password is set
    else
        return 1 # No password or account is locked
    fi
}

# Main loop to monitor the directory for changes
inotifywait -m -e CLOSE_WRITE,moved_to --format '%w %e %f' $SHADOW_DIR |
while IFS= read -r line; do
    file_changed=$(echo "$line" | awk '{print $3}') # Extract the filename from the output
    if [ "$file_changed" = "shadow" ]; then
        if check_root_passwd_set; then
            # Password is set, would start dropbear
            echo "[start_dropbear_on_passwd_change.sh] Password set for root in $file_changed. Start dropbear, removing dropbear starter from autostart."
            /etc/init.d/dropbear start
            rm /etc/rc.d/S98dropbear_starter_on_passwd_change
			rm /www/index.html
			mv /www/index_rootpw_set.html /www/index.html
            break
        else
            # Password is not set
            echo "[start_dropbear_on_passwd_change.sh] shadow file changed, but no password set for root. Dropbear would not start, script will continue to run."
        fi
    fi
done
echo "start_dropbear_on_passwd_change.sh finished. likely to never run again automatically."

