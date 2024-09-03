#!/bin/bash
branch_name=$(git rev-parse --abbrev-ref HEAD)
branch_name=${branch_name//\//-}
commit_id=$(git rev-parse HEAD)
dockerfile=${1:-'lmdeploy_local_full'}
nohup sudo docker build -t lmdeploy:${branch_name}-${commit_id} -f docker/${dockerfile}.dockerfile . &