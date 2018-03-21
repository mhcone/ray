#!/usr/bin/env bash

# This needs to be run in the build tree, which is normally ray/python/ray/core

# Cause the script to exit if a single command fails.
set -e

# Start Redis.
./src/common/thirdparty/redis/src/redis-server --loglevel warning --loadmodule ./src/common/redis_module/libray_redis_module.so --port 6379 &
sleep 1s

# || true allows failures, so cleanup properly executes
killall plasma_store || true
./src/ray/object_manager/object_manager_integration_test || true

./src/common/thirdparty/redis/src/redis-cli -p 6379 shutdown
