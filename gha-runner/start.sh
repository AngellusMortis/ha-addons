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

function update() {
    newBin=$(find . -name "bin.*" -type d)
    if [[ -n $newBin ]]; then
        echo "New bin folder found, replacing..."
        rm ./bin -rf
        mv $newBin ./bin
    fi

    newExt=$(find . -name "externals.*" -type d)
    if [[ -n $newExt ]]; then
        echo "New externals folder found, replacing..."
        rm ./externals -rf
        mv $newExt ./externals
    fi
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

update
/entrypoint.sh ./bin/Runner.Listener run --startuptype service
