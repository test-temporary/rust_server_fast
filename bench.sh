#!/bin/bash
set -e

# Build
cargo build --release

# Start
./target/release/rust_server_fast &

# Ensure exit
SERVER_PID=$!
trap 'kill $SERVER_PID; wait $SERVER_PID' EXIT
sleep 0.5

# Run the benchmark
wrk -t16 -c16 -d30s http://localhost:8080