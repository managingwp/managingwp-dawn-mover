#!/usr/bin/bash
#----------------------------------------------------
# prime-mover-reborn  - v0.0.1
#
# github.com/managingwp/prime-mover-reborn.sh
#
# Original created by Patrick Gallagher (PrimeMover.io)
# -----------------------------------------------------

usage () {
    echo "directadmin2gp <sourceuser> <sourceserver> <sourcedir> <domain>"
}

SRC_USER="$1"
SRC_SERVER="$2"
SRC_DIR="$3" # DIRECT ADMIN DIR
DOMAIN="$4"
DST_DIR="/var/www/${DOMAIN}/htdocs" # GRIDPANE DIR
#SYNC_LOG="/root/synclogs/sync.log"
SYNC_LOG_DIR="$HOME/synclogs"
SYNC_LOG="${SYNC_LOG_DIR}/sync.log"

sync_files () {
    echo "-- time rsync -avzh --progress --exclude 'wp-config.php' ${SRC_USER}@${SRC_SERVER}:${SRC_DIR} ${DST_DIR}"
    read -r -p "Are you sure? [y/n] " response
    if [[ $response == "n" ]]; then
        echo "-- Exiting"
        exit 1
    else
        # -- Check if sh used to run, and run with bash instead
        echo "-- Starting rsync"
        DATE=`date +"%Y-%m-%d %T"`
        echo "Started $DATE" >> ${SYNC_LOG}
        rsync -avzh --progress --exclude 'wp-config.php' ${SRC_USER}@${SRC_SERVER}:${SRC_DIR} ${DST_DIR}  #>> ${SYNC_LOG} 2>&1
        echo "Stopped $DATE" >> ${SYNC_LOG}
    fi
}


# -- Preflight check
if [[ ! -d $SYNC_LOG_DIR ]]; then
    mkdir ${SYNC_LOG_DIR}
    if [[ $? == "1" ]]; then
        echo "Error: couldn't create temp sync dir"
        exit 1
    else
        echo " -- Temp sync dir created"
    fi
else
    echo " -- Temp sync dir exists"
fi

if [[ -z $SRC_USER ]] || [[ -z $SRC_SERVER ]] || [[ -z $SRC_DIR ]] || [[ -z $DOMAIN ]]; then
    usage
    exit 1
else
    sync_files
fi
