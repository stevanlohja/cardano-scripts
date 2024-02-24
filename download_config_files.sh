#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <environment>"
    echo "Valid environments: preview, preprod, mainnet"
    exit 1
fi

ENVIRONMENT="$1"
CONFIG_DIR="$HOME/cardano-$ENVIRONMENT"

mkdir -p $CONFIG_DIR
cd $CONFIG_DIR

declare -a FILES=("config.json" "topology.json" "byron-genesis.json" "shelley-genesis.json" "alonzo-genesis.json" "conway-genesis.json")

if [ "$ENVIRONMENT" != "preview" ] && [ "$ENVIRONMENT" != "preprod" ] && [ "$ENVIRONMENT" != "mainnet" ]; then
    echo "Invalid environment. Valid environments are: preview, preprod, mainnet"
    exit 1
fi

for FILE in "${FILES[@]}"
do
    curl -O -J "https://book.world.dev.cardano.org/environments/$ENVIRONMENT/$FILE"
done