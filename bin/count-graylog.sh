#!/bin/sh

ES_HOST=localhost
DATE=`date +%s --date="3 weeks ago"`;
curl -X GET "http://${ES_HOST}:9200/graylog2_1/_search?pretty=true" -d '{"query": { "range" : { "created_at" : { "lt":'${DATE}' } } } }'
