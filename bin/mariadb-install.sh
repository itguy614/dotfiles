#!/bin/sh

if [ "$(whoami)" != "root" ]; then
    echo "This script must be run as root.  Try sudo, slick"
    exit 1
fi

if [ ! -f /etc/apt/sources.list.d/mariadb.list ]; then
cat >> /etc/apt/sources.list.d/mariadb.list <<-EOF
# MariaDB 5.5 repository list
# http://downloads.mariadb.org/mariadb/repositories/
deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/ubuntu precise main
deb-src http://ftp.osuosl.org/pub/mariadb/repo/5.5/ubuntu precise main
EOF

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

fi

apt-get update
apt-get -y install libmysqlclient18=5.5.30-mariadb1~precise mysql-common=5.5.30-mariadb1~precise libmariadbclient-dev libmariadbclient18 libmariadbd-dev libmysqlclient18 mariadb-client mariadb-client-5.5 mariadb-client-core-5.5 mariadb-common mariadb-server mariadb-server-5.5 mariadb-server-core-5.5 mariadb-test mariadb-test-5.5 mysql-common 
apt-get -y install mariadb-galera-server galera

service mysql stop

cat > /root/.my.cnf <<-EOF
[client]
host     = localhost
user     = root
password = password
socket   = /var/run/mysqld/mysqld.sock
[mysql_upgrade]
host     = localhost
user     = root
password = password
socket   = /var/run/mysqld/mysqld.sock
basedir  = /usr
EOF

chmod 600 /root/.my.cnf

cp /etc/mysql/my.cnf /etc/mysql/my.cnf.orig

cat > /etc/mysql/my.cnf <<-EOF
[client]
port = 3306
socket = /var/run/mysqld/mysqld.sock

[mysqld_safe]
nice = 0
socket = /var/run/mysqld/mysqld.sock

[mysqld]
basedir = /usr
bind-address = 0.0.0.0
binlog_format = ROW
character_set_server = utf8
collation_server = utf8_general_ci
datadir = /var/lib/mysql
default-storage-engine = InnoDB
expire_logs_days = 10
innodb_autoinc_lock_mode = 2
innodb_buffer_pool_size = 256M
innodb_doublewrite = 1
innodb_file_per_table = 1
innodb_flush_log_at_trx_commit = 2
innodb_lock_wait_timeout = 60
innodb_locks_unsafe_for_binlog = 1
innodb_stats_on_metadata = 0
key_buffer = 256M
lc-messages-dir = /usr/share/mysql
lock_wait_timeout = 300
max_allowed_packet = 128M
max_binlog_size = 128M
max_connections = 64
myisam-recover = BACKUP
myisam_sort_buffer_size = 64M
net_buffer_length = 8K
open-files-limit = 65535
pid-file = /var/run/mysqld/mysqld.pid
port = 3306
query_cache_limit = 8M
query_cache_size = 16M
read_buffer_size = 8M
read_rnd_buffer_size = 8M
skip-external-locking
socket = /var/run/mysqld/mysqld.sock
sort_buffer_size = 16M
table_cache = 2M
table_definition_cache = 65535
table_open_cache = 65535
thread_cache_size = 8
thread_concurrency = 8
tmpdir = /tmp
user = mysql

[mysqldump]
max_allowed_packet = 16M
quick
quote-names

[mysql]

[isamchk]
!includedir /etc/mysql/conf.d/
key_buffer = 256M
read_buffer = 16M
sort_buffer_size = 256M
write_buffer = 16M
EOF

cp /etc/mysql/conf.d/mariadb.cnf /etc/mysql/conf.d/mariadb.cnf.orig

cat > /etc/mysql/conf.d/mariadb.cnf <<-EOF
[mysqld]
wsrep_cluster_address = 'gcomm://'
wsrep_provider = /usr/lib/galera/libgalera_smm.so
wsrep_retry_autocommit = 0
wsrep_sst_method = rsync
EOF

service mysql start

echo When prompted, enter the MySQL root user password
mysql -p -e "SET wsrep_on = OFF; DELETE FROM mysql.user WHERE user = '';"
mysql -p -e "SET wsrep_on = OFF; GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'password';"
