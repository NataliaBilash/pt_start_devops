#!/bin/bash
set -Eeo pipefail

/usr/local/bin/docker-entrypoint.sh postgres &

wait $!
