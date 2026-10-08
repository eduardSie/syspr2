#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <program> [program arguments...]" >&2
    exit 64
fi

: "${FLAMEGRAPH_DIR:?Set FLAMEGRAPH_DIR to the FlameGraph directory.}"
collapse="$FLAMEGRAPH_DIR/stackcollapse-perf.pl"
render="$FLAMEGRAPH_DIR/flamegraph.pl"
if [[ ! -x "$collapse" || ! -x "$render" ]]; then
    echo "FlameGraph scripts were not found in FLAMEGRAPH_DIR=$FLAMEGRAPH_DIR" >&2
    exit 69
fi
if ! command -v perf >/dev/null; then
    echo "perf is not installed. On Fedora: sudo dnf install perf" >&2
    exit 69
fi

mkdir -p results
name=$(basename "$1")
data="results/${name}.perf.data"
script="results/${name}.perf-script.txt"
folded="results/${name}.folded"
svg="results/${name}.flamegraph.svg"

perf record -e cpu-clock -F 99 -g --call-graph dwarf -o "$data" -- "$@"
perf report --stdio -i "$data" > "results/${name}.perf-report.txt"
perf script -F -period -i "$data" > "$script"
"$collapse" "$script" > "$folded"
"$render" --title "${name}: CPU time samples (cpu-clock, 99 Hz)" "$folded" > "$svg"
echo "Saved $data, perf report, folded stacks, and $svg"
