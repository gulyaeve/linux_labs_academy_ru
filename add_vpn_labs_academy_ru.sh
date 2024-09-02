#!/usr/bin/env bash

# Проверка что скрипт запускается от root
if [ $(id -u) -ne 0 ]; then
    echo "Запустите данный скрипт с правами root"
    exit 0
fi

echo "Вы запустили скрипт для добавления VPN-соединения labs.academy.ru"

echo "Добавляю VPN-соединение"

# Создание подключения
nmcli connection add connection.id labs.academy.ru con-name labs.academy.ru type vpn vpn-type pptp vpn.data "gateway = labs.academy.ru, lcp-echo-failure = 5, lcp-echo-interval = 30, mppe-stateful = yes, password-flags = 1, refuse-chap = yes, refuse-eap = yes, refuse-pap = yes, require-mppe-128 = yes" ipv4.never-default yes

# Копирование скрипта для прописывания маршрутов в диспетчер NetworkManager
cp 01-vpn-up-labs /etc/NetworkManager/dispatcher.d/
chown root /etc/NetworkManager/dispatcher.d/01-vpn-up-labs
chmod u+x /etc/NetworkManager/dispatcher.d/01-vpn-up-labs

# Перезапуск NetworkManager
systemctl restart NetworkManager

exit 0
