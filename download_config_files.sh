#!/bin/bash
CONFIG_DIR="$HOME/cardano-testnet"

mkdir -p $CONFIG_DIR
cd $CONFIG_DIR

declare -a FILES=("config.json" "topology.json" "byron-genesis.json" "shelley-genesis.json" "alonzo-genesis.json" "conway-genesis.json")

for FILE in "${FILES[@]}"
do
    curl -O -J "https://book.world.dev.cardano.org/environments/preprod/$FILE"
done