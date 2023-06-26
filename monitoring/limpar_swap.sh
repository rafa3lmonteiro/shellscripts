#!/bin/sh

sync ; echo 3 > /proc/sys/vm/drop_caches
sync ; echo 2 > /proc/sys/vm/drop_caches
sync ; echo 1 > /proc/sys/vm/drop_caches

sysctl -w vm.drop_caches=3
swapoff -a && swapon -a
