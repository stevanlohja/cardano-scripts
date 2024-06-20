#!/bin/bash

mkdir -p $HOME/config $HOME/db $HOME/keys
curl -o $HOME/config/config.json -J https://book.world.dev.cardano.org/environments/preview/config.json
curl -o $HOME/config/db-sync-config.json -J https://book.world.dev.cardano.org/environments/preview/db-sync-config.json
curl -o $HOME/config/submit-api-config.json -J https://book.world.dev.cardano.org/environments/preview/submit-api-config.json
curl -o $HOME/config/topology.json -J https://book.world.dev.cardano.org/environments/preview/topology.json
curl -o $HOME/config/byron-genesis.json -J https://book.world.dev.cardano.org/environments/preview/byron-genesis.json
curl -o $HOME/config/shelley-genesis.json -J https://book.world.dev.cardano.org/environments/preview/shelley-genesis.json
curl -o $HOME/config/alonzo-genesis.json -J https://book.world.dev.cardano.org/environments/preview/alonzo-genesis.json
curl -o $HOME/config/conway-genesis.json -J https://book.world.dev.cardano.org/environments/preview/conway-genesis.json