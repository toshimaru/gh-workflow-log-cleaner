[![test](https://github.com/toshimaru/gh-workflow-log-cleaner/actions/workflows/test.yml/badge.svg)](https://github.com/toshimaru/gh-workflow-log-cleaner/actions/workflows/test.yml)

# GitHub Workflow Log Cleaner

Clean up your outdated GitHub Actions workflow logs.

![OG Image](./img/og.png)

## Usage

```console
$ gh workflow-log-cleaner "Your Workflow Name (<workflow-id> or <workflow-name> or <filename>)"
```

## Don't know your workflow name?

If you don't know your workflow name or workflow id, you can find it by running `gh workflow-log-cleaner` without any arguments.

```console
$ gh workflow-log-cleaner
Usage:
gh workflow-log-cleaner [<workflow-id> | <workflow-name> | <filename>]

Available workflows:
NAME   STATE   ID
setup  active  114854128
test   active  114855097
```
