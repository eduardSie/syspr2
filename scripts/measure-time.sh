#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <program> [program arguments...]" >&2
    exit 64
fi

mkdir -p results
name=$(basename "$1")
/usr/bin/time --verbose --output="results/${name}.time.txt" "$@"
echo "Saved /usr/bin/time output to results/${name}.time.txt"
