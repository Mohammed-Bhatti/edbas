#!/bin/bash

###################################################################################
#title           : EFM fencing script for updating pgpool
#description     : This script executes pcp commands. Therefore pcp & pgpool 
#                : should be available on the server
#author          : Vibhor Kumar (vibhor.aim@gmail.com).
#date            : Jan 5 2018
#version         : 1.0
#notes           : Install Vim and Emacs to use this script.
#                : configure the pcppass file for EFM user and set 
#                : the password correctly
#bash_version    : GNU bash, version 4.2.46(2)-release (x86_64-redhat-linux-gnu)
###################################################################################
# quit on any error
set -e
# verify any  undefined shell variables
set -u

###################################################################################
# Code for notifiying pgpool for promote the standby
###################################################################################

NEW_PRIMARY=$1                              # argument from EFM fencing hook
PCP_USER=pgpool                             # PCP user name
PCP_PORT=9898                               # PCP port number as in pgpool.conf
PCP_HOST=pgpool                             # hostname of Pgpool-II  
PGPOOL_PATH=/usr/edb/pgpool3.6              # Pgpool-II installation path
PCPPASSFILE=/var/efm/pcppass                # Path to PCPPASS file

PCP_NODE_COUNT=${PGPOOL_PATH}/bin/pcp_node_count
PCP_NODE_INFO=${PGPOOL_PATH}/bin/pcp_node_info
PCP_PROMOTE=${PGPOOL_PATH}/bin/pcp_promote_node
 
export PCPPASSFILE PCP_USER PCP_PORT PGPOOL_PATH \
       PCP_PROMOTE PCP_NODE_INFO PCP_NODE_COUNT

###################################################################################
# find the number of nodes and search for node-id of NEW_PRIMARY
###################################################################################
NO_OF_NODES=$(${PCP_NODE_COUNT} --host=${PCP_HOST} \
                      --username=${PCP_USER} \
                      --port=${PCP_PORT} \
                      --no-password )

for (( i=0 ; i < ${NO_OF_NODES} ; i++ ))
do
   exists=$(${PCP_NODE_INFO} --host=${PCP_HOST} \
                    --username=${PCP_USER} \
                    --port=${PCP_PORT} \
                    --no-password ${i} |grep ${NEW_PRIMARY}|wc -l)
   if [[ ${exists} -eq 1 ]]; then
      NODE_ID=${i}
      break
   fi
done

###################################################################################
# Promote the specific node id using PCP command
###################################################################################
if [[ ! -z ${NODE_ID} ]]; then
    ${PCP_PROMOTE} --host=${PCP_HOST} \
                   --username=${PCP_USER} \
                   --port=${PCP_PORT} \
                   --no-password \
                   --verbose \
                   ${NODE_ID}
fi
exit 0
