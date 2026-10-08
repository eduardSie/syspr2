#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <program> [program arguments...]" >&2
    exit 64
fi

batteries=(/sys/class/power_supply/BAT*)
if [[ ! -e ${batteries[0]} ]]; then
    echo "No battery power sensor was found. Run on battery power with BAT*/power_now available." >&2
    exit 69
fi

battery=${batteries[0]}
if [[ ! -r "$battery/power_now" ]]; then
    echo "$battery/power_now is unavailable; this sensor cannot measure system power." >&2
    exit 69
fi

mkdir -p results
name=$(basename "$1")
output="results/${name}.system-power.csv"
printf 'elapsed_seconds,power_watts\n' > "$output"

"$@" &
program_pid=$!
start_ns=$(date +%s%N)

sample() {
    local now_ns power_uw
    now_ns=$(date +%s%N)
    power_uw=$(<"$battery/power_now")
    awk -v now="$now_ns" -v start="$start_ns" -v power="$power_uw" \
        'BEGIN { printf "%.3f,%.6f\n", (now-start)/1e9, power/1e6 }' >> "$output"
}

sample
while kill -0 "$program_pid" 2>/dev/null; do
    sleep 0.1
    if kill -0 "$program_pid" 2>/dev/null; then
        sample
    fi
done

wait "$program_pid"
sample
awk -F, 'NR == 2 { previous_time = $1; previous_power = $2; next }
    NR > 2 {
        energy += ($1 - previous_time) * (previous_power + $2) / 2
        previous_time = $1
        previous_power = $2
    }
    END {
        if (NR < 3) {
            print "Not enough samples to estimate system energy." > "/dev/stderr"
            exit 1
        }
        printf "Estimated system energy: %.6f J\n", energy
    }' "$output"
echo "Saved battery system-power samples to $output"
