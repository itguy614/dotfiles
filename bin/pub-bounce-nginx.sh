#!/bin/sh

ssh kwolf@10.2.10.40 'sudo service nginx reload'
ssh kwolf@10.2.10.42 'sudo service nginx reload'
ssh kwolf@10.2.10.44 'sudo service nginx reload'
