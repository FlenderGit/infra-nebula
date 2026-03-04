#!/bin/bash
set -a
source .env
set +a

docker stack deploy -c docker-stack.yml nebula
