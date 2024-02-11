#!/usr/bin/env bash

# Retrieve memory information using awk
MEM_FREE=$(awk '/^MemFree/ {print int($2/1024)}' /proc/meminfo)
MEM_TOTAL=$(awk '/^MemTotal/ {print int($2/1024)}' /proc/meminfo)
MEM_THRESHOLD=1024

# Check for root permissions or sudo availability
if ! [ "$(id -u)" -eq 0 ] && ! command -v sudo &>/dev/null; then
  echo "Superuser privileges are required."
  exit 1
fi

if [ "$MEM_FREE" -le "$MEM_THRESHOLD" ]; then
  echo "Clearing PageCache, dentries, and inodes..."
  if [ "$(id -u)" -eq 0 ]; then
    sync
    echo 3 >/proc/sys/vm/drop_caches
  else
    sudo sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'
  fi
  echo "Memory caches cleared."

  echo "Deflating memory..."
  echo 1 >/proc/sys/vm/compact_memory
  echo "Memory deflated."

  MEM_AFTER=$(awk '/^MemFree/ {print int($2/1024)}' /proc/meminfo)
  echo "Total Memory: $MEM_TOTAL MB"
  echo "Free Memory before: $MEM_FREE MB"
  echo "Free Memory after: $MEM_AFTER MB"
  echo
  echo "Memory caches cleared and memory deflated successfully."
else
  echo "No need to clear memory cache."
fi

exit 0
