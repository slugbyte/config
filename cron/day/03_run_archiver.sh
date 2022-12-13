#!/usr/bin/env bash
source $HOME/workspace/hide/env/kiipo.sh
source $HOME/workspace/hide/env/kiipo_pg.sh
source $HOME/workspace/hide/env/kiipo_mongo.sh
cd /opt/pomelo_backend
npm run release:archiver
npm run staging:archiver
npm run develop:archiver
