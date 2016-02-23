#!/bin/sh

if [ "$(whoami)" != "root" ]; then
    echo "This script must be run as root.  Try sudo, slick"
    exit 1
fi

apt-get update

apt-get -y remove apparmor apparmor-utils

apt-get -y install mysql-common

apt-get -y install php5-common php5-cli php5-fpm php5-mysql php5-mcrypt php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-sybase php5-tidy php5-xmlrpc php5-xsl nginx

apt-get -y install libpcre3-dev php-pear build-essential

pecl install apc

rm -Rf /etc/php5/conf.d/apc.ini
cat > /etc/php5/conf.d/apc.ini <<-EOF
extension=apc.so
apc.enabled=1
apc.shm_size=30
EOF
