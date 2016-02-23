#!/bin/sh

ES_HOST=localhost
DATE=`date +%s --date="2 weeks ago"`;

curl -XDELETE "http://${ES_HOST}:9200/graylog2_0/_query" -d ' { "range" : {"created_at" : { "lt" : "'${DATE}'" } } }'
