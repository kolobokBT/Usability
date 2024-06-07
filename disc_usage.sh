#!/bin/bash
MOUNT_POINTS=("/" "/docker" "/var")
THRESHOLD=80

for mount in "${MOUNT_POINTS[@]}"; do
		usage=$(df -h | awk '$NF=="'"$mount"'" { print $5 }' | sed 's/%//g')

		if [[ "$usage" =~ ^[0-9]+$ ]] && [ "$usage" -ge "$THRESHOLD" ]; then
		subject="Storage Alert: $mount is at $usage% usage"
        body="Administrator,\n\nThe storage usage on mount point $mount has reached $usage%. Please take necessary actions to prevent any issues.\n\nRegards,\nSystem Monitor"
        mail -s "$subject" admin@mail.com << EOF
$body
EOF
	fi
done
