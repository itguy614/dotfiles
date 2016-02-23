#!/bin/sh

if [ "$(whoami)" != "root" ]; then
    echo "This script must be run as root.  Try sudo, slick"
    exit 1
fi

apt-get -y install haproxy mysql-client-5.5

sed -i s/0/1/ /etc/default/haproxy

service haproxy stop

cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.orig

cat > /etc/haproxy/haproxy.cfg <<-EOF
global
	log 127.0.0.1	local0
	log 127.0.0.1	local1 notice
	maxconn 1024
	user haproxy
	group haproxy
	daemon

defaults
	log	global
	mode	http
	option	tcplog
	option	dontlognull
	retries	3
	option	redispatch
	maxconn	1024
	timeout	connect	5000ms
	timeout	client	5000ms
	timeout	server	5000ms

listen galera_cluster 0.0.0.0:3306
	mode	tcp
	balance	roundrobin
	option	tcpka
	option	mysql-check user haproxy
	server	gallodb01 10.2.10.137:3306
	server	gallodb02 10.2.10.138:3306
EOF

service haproxy start
