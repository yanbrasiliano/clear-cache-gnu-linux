#!/usr/bin/env bash

# Memory Information
MEM_LIVRE=`cat /proc/meminfo | grep "^MemFree" | tr -s ' ' | cut -d ' ' -f2` && MEM_LIVRE=`echo "$MEM_LIVRE/1024.0" | bc`
MEM_TOTAL=`cat /proc/meminfo | grep "^MemTotal" | tr -s ' ' | cut -d ' ' -f2` && MEM_TOTAL=`echo "$MEM_TOTAL/1024.0" | bc`
MEM_MIN=`echo 1024`

# If work only SUDO.
SUDO=`which sudo`
if [ "`whoami`" == "root" ]; then ROOT=true; fi
if [ ! "`which sudo`" ] && [ !$ROOT ]; then echo "Not superuser and SUDO not found"; exit 1; fi


if [ "$MEM_LIVRE" -le "$MEM_MIN" ]
then
     # Clear PageCache, dentries, and inodes
    echo "Clearing PageCache, dentries, and inodes..."
    if [ $ROOT ]; then sync; echo 3 > /proc/sys/vm/drop_caches; else $SUDO sync; echo 3 | $SUDO tee /proc/sys/vm/drop_caches > /dev/null; fi
    sync; echo 2 > /proc/sys/vm/drop_caches
    sync; echo 3 > /proc/sys/vm/drop_caches
    echo "Memory caches cleared."
    # Deflate memory
    echo "Deflating memory..."
    echo 1 > /proc/sys/vm/compact_memory
    echo "Memory deflated".
    MEM_APOS=`cat /proc/meminfo | grep "^MemFree" | tr -s ' ' | cut -d ' ' -f2` && MEM_APOS=`echo "$MEM_APOS/1024.0" | bc`
    echo "Total Memory: $MEM_TOTAL MB"
    echo "Free Memory: $MEM_LIVRE MB"
    echo "Free Memory after execution: $MEM_APOS MB"
    echo
    echo "Memory caches cleared and memory deflated successfully."
else
    echo "No need to clear your memory cache."
fi

exit 0
