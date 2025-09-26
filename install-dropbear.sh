#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
   echo "Skrip ini harus dijalankan sebagai root" 1>&2
   exit 1
fi

echo "=> Memulai Instalasi & Konfigurasi Dropbear..."
apt install dropbear -y >/dev/null 2>&1
echo 'NO_START=0' >> /etc/default/dropbear
echo 'DROPBEAR_PORT=143' >> /etc/default/dropbear
echo 'DROPBEAR_EXTRA_ARGS="-p 109"' >> /etc/default/dropbear
systemctl daemon-reload >/dev/null 2>&1
systemctl start dropbear >/dev/null 2>&1
systemctl restart dropbear >/dev/null 2>&1
echo ""
echo "✅ Instalasi & Konfigurasi Dropbear Selesai!"
