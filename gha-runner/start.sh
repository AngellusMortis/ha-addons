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

function linkDataVolume() {
    echo "Linking /data volume to /actions-runner"
    rm /actions-runner -rf
    ln -s /data /actions-runner
}

if [[ -f "/data/.runner" ]]; then
    if [[ ! -f "/actions-runner/.runner" ]]; then
        linkDataVolume
    fi
else
    echo "Runner not configured yet, moving /actions-runner"
    mv /actions-runner/* /data/
    linkDataVolume
fi

/entrypoint.sh ./bin/Runner.Listener run --startuptype service
