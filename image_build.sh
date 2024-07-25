#!/bin/bash
branch_name=$(git rev-parse --abbrev-ref HEAD)
branch_name=${branch_name//\//-}
commit_id=$(git rev-parse HEAD)
nohup sudo docker build -t lmdeploy:${branch_name}-${commit_id} -f docker/lmdeploy_local.dockerfile . &