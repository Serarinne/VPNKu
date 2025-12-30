#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
   echo "Skrip ini harus dijalankan sebagai root" 1>&2
   exit 1
fi

echo "=> Memulai Instalasi & Konfigurasi Dropbear..."
wget http://matt.ucc.asn.au/dropbear/releases/dropbear-2019.78.tar.bz2 >/dev/null 2>&1
tar -xvf dropbear-2019.78.tar.bz2
cd dropbear-2019.78
./configure
make
make install
echo 'NO_START=0' >> /etc/default/dropbear
echo 'DROPBEAR_PORT=143' >> /etc/default/dropbear
echo 'DROPBEAR_EXTRA_ARGS="-p 109"' >> /etc/default/dropbear

systemctl restart dropbear >/dev/null 2>&1
echo ""
echo "✅ Instalasi & Konfigurasi Dropbear Selesai!"
