# GHA Runner

## Required Configuration

* `repo`: URL to your Github repo you want to run the GHA runner on
* `token`: time based token to create GHA runner

### Getting new GHA Runner Token

1. On your Github repo, Go to Settings -> Actions -> Runners and click "New self-hosted runner"
2. Copy the value after the `--token` argument under the "Configure" section

## Optional Configuration

* `name`: Name for GHA runner (will appear in Settings and workflow logs)
* `labels`: Comma list of extra labels you want to apply to the runner. Gets `self-hosted` by default.
* `workdir`: Path where your GHA runner data is stored. Defaults to `/share/gha-runner` which is a folder accessible by Home Assistant. If you would like to change it a folder HA core / other add-ons cannot see use `/data/gha-runner`.

### About Labels

[Github Docs](https://docs.github.com/en/actions/hosting-your-own-runners/using-labels-with-self-hosted-runners)

Labels are used to "route" workflow runs. These map directly to the `run-on` option for a job. Example, if your GHA runner has the labels `self-hosted,linux,foo` and your job has `runs-on: [self-hosted,linux,bar]`, it will **not** use your GHA runner.
