#!/usr/bin/env bash
set -o nounset -o pipefail

inotifywait -e modify,move,create,delete --recursive --monitor --format "%e %w%f" src | while read changed; do echo $changed; scripts/test-rust.sh; done
