#!/bin/bash
set -a
source .env
set +a

docker node update --label-add nats=1 nebula-deloeit-2
docker node update --label-add nats=2 nebula-deloeit-1

docker stack deploy -c stack.yml nebula
