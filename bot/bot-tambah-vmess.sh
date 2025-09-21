#!/bin/bash
CONFIG_PATH="/usr/local/etc/xray/config.json"
CLIENT_EMAIL = $1
NEW_UUID = $2

if [ -z "$CLIENT_EMAIL" ]; then
    echo "Email tidak boleh kosong."
    return
fi

if jq -e '.inbounds[0].settings.clients[] | select(.email == "'"$CLIENT_EMAIL"'")' $CONFIG_PATH > /dev/null; then
    echo "Klien dengan email '$CLIENT_EMAIL' sudah ada."
    return
fi

NEW_CLIENT_JSON=$(jq -n --arg id "$NEW_UUID" --arg email "$CLIENT_EMAIL" '{id: $id, level: 0, alterId: 0, email: $email}')

TEMP_JSON=$(jq '.inbounds[0].settings.clients += ['"$NEW_CLIENT_JSON"']' $CONFIG_PATH)

echo "$TEMP_JSON" > $CONFIG_PATH

echo "1"

systemctl restart xray