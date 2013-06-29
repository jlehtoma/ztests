#!/bin/sh
taskset -c 0 './zbenchmark.py -l test_suite_esmk_threads.yaml -x zig4'
