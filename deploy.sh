#!/bin/bash
set -a
source .env
set +a

docker stack deploy -c stack.yml nebula
