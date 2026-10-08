#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <program> [program arguments...]" >&2
    exit 64
fi

if ! command -v perf >/dev/null; then
    echo "perf is not installed. On Fedora: sudo dnf install perf" >&2
    exit 69
fi

mkdir -p results
name=$(basename "$1")
perf stat -d -o "results/${name}.perf-stat.txt" -- "$@"
echo "Saved perf stat output to results/${name}.perf-stat.txt"
