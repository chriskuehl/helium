#!/bin/sh
lxc-list | awk '/RUNNING/,/FROZEN/' | tail -n +2 | head -n -2 | sed 's/ //g'
