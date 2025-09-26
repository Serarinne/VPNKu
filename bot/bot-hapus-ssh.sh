#!/bin/bash
USERNAME=$1

if ! id "$USERNAME" &>/dev/null; then
    echo "Pengguna '$USERNAME' tidak ditemukan."
    exit 1
fi

deluser --remove-home "$USERNAME"

echo "1"
