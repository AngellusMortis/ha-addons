#!/usr/bin/env bashio

export REPO_URL=$(bashio::config 'repo')
export RUNNER_NAME=$(bashio::config 'name')
export RUNNER_TOKEN=$(bashio::config 'token')
export RUNNER_WORKDIR=$(bashio::config 'workdir')
export LABELS=$(bashio::config 'labels')

echo "Config:"
echo "REPO_URL=$REPO_URL"
echo "RUNNER_NAME=$RUNNER_NAME"
echo "RUNNER_WORKDIR=/data"
echo "LABELS=$LABELS"
echo

/entrypoint.sh ./bin/Runner.Listener run --startuptype service
