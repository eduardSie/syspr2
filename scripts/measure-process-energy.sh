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

echo "Measuring CPU package energy, including background activity, during the command."
echo "System-wide perf access is required; perf_event_paranoid=1 blocks unprivileged access." >&2
perf stat -a -e power/energy-pkg/ -o "results/${name}.process-energy.txt" -- "$@"
echo "Saved RAPL process-window estimate to results/${name}.process-energy.txt"
