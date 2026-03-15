#!/bin/bash
set -a
source .env
set +a

docker node update --label-add nats=1 ubuntu1-deloeilt
docker node update --label-add nats=2 ubuntu2-deloeilt

docker stack deploy -c stack.yml nebula
