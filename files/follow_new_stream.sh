#!/bin/bash
set -x
primary_node_host_name=$2
detached_node_host_name=$1
detached_node_id=$3

tmp=/tmp/mytemp$$
trap "/usr/bin/rm -f $tmp" 0 1 2 3 15


