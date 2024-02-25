#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <environment>"
    echo "Valid environments: preview, preprod, mainnet"
    exit 1
fi

ENVIRONMENT="$1"
NODE_DIR="$HOME/cardano-$ENVIRONMENT"
PORT=6000
HOSTADDR=0.0.0.0
TOPOLOGY="$NODE_DIR/topology.json"
DB_PATH="$NODE_DIR/db"
SOCKET_PATH="$NODE_DIR/db/socket"
CONFIG="$NODE_DIR/config.json"

/usr/bin/cardano-node run --topology $TOPOLOGY --database-path $DB_PATH --socket-path $SOCKET_PATH --host-addr $HOSTADDR --port $PORT --config $CONFIG