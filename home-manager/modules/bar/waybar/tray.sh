#!/usr/bin/env bash

count=$(busctl --user get-property org.kde.StatusNotifierWatcher /StatusNotifierWatcher org.kde.StatusNotifierWatcher RegisteredStatusNotifierItems | sed 's/.* \([0-9]\+\) .*/\1/')
if [ "$count" -gt 0 ]; then
    echo " $count   "
fi