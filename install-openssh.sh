#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
   echo "Skrip ini harus dijalankan sebagai root" 1>&2
   exit 1
fi

echo "=> Memulai Instalasi & Konfigurasi OpenSSH..."
sed -i '/^Port/d' /etc/ssh/sshd_config >/dev/null 2>&1
sed -i '/^X11Forwarding/d' /etc/ssh/sshd_config >/dev/null 2>&1
sed -i '/^AllowTcpForwarding/d' /etc/ssh/sshd_config >/dev/null 2>&1
sed -i '/^PermitRootLogin/d' /etc/ssh/sshd_config >/dev/null 2>&1
cat <<EOF >> /etc/ssh/sshd_config >/dev/null 2>&1
Port 22
Port 40000
X11Forwarding yes
AllowTcpForwarding yes
PermitRootLogin yes
PasswordAuthentication yes
EOF
systemctl daemon-reload >/dev/null 2>&1
systemctl start ssh >/dev/null 2>&1
systemctl restart ssh >/dev/null 2>&1
echo ""
echo "✅ Instalasi & Konfigurasi OpenSSH Selesai!"