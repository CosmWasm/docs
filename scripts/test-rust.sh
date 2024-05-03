#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

(
    cd docs-test-gen && \
    rm -rf ./tests && \
    cargo run &&
    cargo test
)