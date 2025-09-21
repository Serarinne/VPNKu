#!/bin/bash
CONFIG_PATH="/usr/local/etc/xray/config.json"
CLIENT_EMAIL = $1

if [ -z "$CLIENT_EMAIL" ]; then
    echo "Email tidak boleh kosong."
    return
fi

if ! jq -e '.inbounds[0].settings.clients[] | select(.email == "'"$CLIENT_EMAIL"'")' $CONFIG_PATH > /dev/null; then
    echo "Klien dengan email '$CLIENT_EMAIL' tidak ditemukan."
    return
fi

TEMP_JSON=$(jq 'del(.inbounds[0].settings.clients[] | select(.email == "'"$CLIENT_EMAIL"'"))' $CONFIG_PATH)

echo "$TEMP_JSON" > $CONFIG_PATH

echo "Klien '$CLIENT_EMAIL' berhasil dihapus."

echo "1"

systemctl restart xray