#!/bin/sh
taskset -c 0 zig4 -r 15_60_5kp_abf_pe/15_60_5kp_abf_pe.dat 15_60_5kp_abf_pe/15_60_5kp_abf_pe.spp ../output/result_15_60_5kp_abf_pe.txt 0 0 1 0 --grid-output-formats=compressed-img --use-threads=1
