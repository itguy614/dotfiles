#!/bin/sh

ssh root@10.2.10.40 'service php5-fpm restart'
ssh root@10.2.10.42 'service php5-fpm restart'
ssh root@10.2.10.44 'service php5-fpm restart'
