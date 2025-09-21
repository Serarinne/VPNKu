#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
   echo "Skrip ini harus dijalankan sebagai root" 1>&2
   exit 1
fi

CONFIG_PATH="/usr/local/etc/xray/config.json"

read -p "Masukkan email untuk klien baru: " CLIENT_EMAIL

if [ -z "$CLIENT_EMAIL" ]; then
    echo "Email tidak boleh kosong."
    return
fi

if jq -e '.inbounds[0].settings.clients[] | select(.email == "'"$CLIENT_EMAIL"'")' $CONFIG_PATH > /dev/null; then
    echo "Klien dengan email '$CLIENT_EMAIL' sudah ada."
    return
fi

NEW_UUID=$(xray uuid)

NEW_CLIENT_JSON=$(jq -n --arg id "$NEW_UUID" --arg email "$CLIENT_EMAIL" '{id: $id, level: 0, alterId: 0, email: $email}')

TEMP_JSON=$(jq '.inbounds[0].settings.clients += ['"$NEW_CLIENT_JSON"']' $CONFIG_PATH)

echo "$TEMP_JSON" > $CONFIG_PATH

echo "✅ Klien berhasil ditambahkan!"
echo "   Email: $CLIENT_EMAIL"
echo "   UUID : $NEW_UUID"

systemctl restart xray

read -p "$(echo -e "Tekan [Enter] untuk kembali")"
exit 0