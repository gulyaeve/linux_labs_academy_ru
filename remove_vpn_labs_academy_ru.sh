#!/usr/bin/env bash

# Проверка что скрипт запускается от root
if [ $(id -u) -ne 0 ]; then
    echo "Запустите данный скрипт с правами root"
    exit 0
fi

echo "Вы запустили скрипт для удаления VPN-соединения labs.academy.ru"

echo "Удаляю VPN-соединение"

# Удаление подключения
nmcli connection delete labs.academy.ru

# Удаление скрипта для прописывания маршрутов в диспетчер NetworkManager
rm -f /etc/NetworkManager/dispatcher.d/01-vpn-up-labs

# Перезапуск NetworkManager
systemctl restart NetworkManager

exit 0
