#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import datetime
import os
import platform
from pprint import pprint
from subprocess import Popen, PIPE
import sys
import time

from zparser import parse_results

def get_system_info():
    ''' Function to retrieve system related information.

    @return list of system variables
    '''
    sys_info = []
    sys_info.append({'Report time': datetime.datetime.now().isoformat()})
    sys_info.append({'Uname': platform.uname()})

    if platform.system() == 'Linux':
        sys_info.append({'Version': platform.linux_distribution()})
    else:
        sys_info.append({'Version': platform.win32_ver()})

    return sys_info


def get_zonation_info():
    ''' Function to retrieve Zonation version info.

    NOTE: Zonation must be in PATH.

    @return tuple Zonation version number
    '''
    version = Popen(['zig3', '-v'], stdout=PIPE)
    version = version.communicate()[0]
    version = version.split('\n')[0].strip()
    version = version.split(':')[1].strip()
    version = tuple(version.split('.'))

    return version


def pad_header(msg, print_width):

    # - 4 is for 2 leading stars and 2 whitespaces
    nstars = print_width - len(msg) - 4
    return '\n** ' + msg + ' ' + '*' * nstars


def read_run(file_list):
    ''' Reads in the Zonation bat/sh files and return a dict of command sequences.

    If an item in the list does not exist, it is removed from the file list.
    '''

    cmd_sequences = {}

    for file_path in file_list:

        try:
            f = open(file_path, 'r')
        except IOError:
            print('WARNING: File {0} does not exist'.format(file_path))
            file_list.remove(file_path)
            continue

        # Read the input files and parse the Zonation call sequence. A single bat/sh file can
        # have more than 1 row
        with f:
            content = f.readlines()
            for sequence in content:
                # On Unix systems hashbang can be included, do not include it
                if not sequence.startswith("#!"):
                    # Strip the trailing newline
                    sequence = sequence.replace('\n', '')
                    sequence = sequence.replace('\r', '')
                    # If we are on linux, get rid of .exe
                    if platform.system() == 'Linux':
                        sequence = sequence.replace('.exe', '')
                    # Split the sequence
                    sequence = sequence.split(' ')
                    # Remove 'call' arg
                    if 'call' in sequence:
                        sequence.remove('call')
                    cmd_sequences[file_path] = sequence

    if cmd_sequences:
        return cmd_sequences
    else:
        print('ERROR: None of the input files exist')
        sys.exit(1)


def run_suite():
    pass


def run_analysis(file_path, cmd_args):
    ''' Zonation analysis runner.

    Runs a single analysis based on parsed arguments.

    @param name String name of the analysis being run
    @param cmd_args list of Zonation command line arguments

    @return elapsed_times dict of seconds of analysis runtime
    '''

    t0 = time.time()
    p = Popen(cmd_args, cwd=os.path.dirname(file_path))
    p.wait()
    t1 = time.time()

    total = t1 - t0

    # Get also the times reported by Zonation. Output name pattern is the 5th item in the bat/sh
    # file
    output_filepath = cmd_args[4].replace('.txt', '.run_info.txt')
    output_filepath = os.path.join(os.path.dirname(file_path), output_filepath)
    elapsed_times = parse_results(output_filepath)
    elapsed_times['measured'] = round(total, 0)

    return elapsed_times


def write_output(output_data, output_file=None, silent=False, print_width=80):

    if not silent:
        print(pad_header('SYSTEM INFO', print_width))
        pprint(output_data['sys_info'], width=print_width)
        print(pad_header('ZONATION INFO', print_width))
        print('Zonation version number: {0}'.format(output_data['z_info']))
        print(pad_header('BENCHMARK INFO', print_width))

        keys = output_data.keys()
        keys.sort()
        for key in keys:
            if key not in ['sys_info', 'z_info']:
                print('{0}:'.format(key))
                print('in seconds')
                pprint(output_data[key], width=print_width)
    if output_file:
        import yaml
        with open(output_file, 'w') as outfile:
            outfile.write(yaml.dump(output_data, canonical=True))
        print('INFO: Wrote result data to {0}'.format(output_file))


def main():
    parser = argparse.ArgumentParser(description='Run Zonation performance benchmarks.')

    parser.add_argument('input_files', metavar='INPUTS', type=str, nargs='?',
                        help='input bat/sh file')
    parser.add_argument('-l', '--load', dest='input_yaml', metavar="YAMLFILE",
                        help='yaml file defining a suite of input files')
    parser.add_argument('-o', '--outputfile', dest='output_file', default='',
                        help='name of the output file')

    args = parser.parse_args()

    if args.input_yaml:
        if args.input_files:
            print('WARNING: Both positional input files and loadable yaml file defined. Using positional input files.')
        else:
            import yaml
            try:
                f = open(args.input_yaml, 'r')
            except IOError:
                print('ERROR: Input YAML file {0} does not exist'.format(args.input_yaml))
                sys.exit(1)
            with f:
                suite = yaml.safe_load(f)
                args.input_files = suite['benchmark_analyses']

    args.input_files = [os.path.abspath(item) for item in args.input_files]

    cmd_args = read_run(args.input_files)

    # Collect output to a dict
    output = {}
    output['sys_info'] = get_system_info()
    output['z_info'] = get_zonation_info()

    for file_path, _cmd_args in cmd_args.iteritems():
        output[file_path] = run_analysis(file_path, _cmd_args)

    write_output(output, args.output_file)

if __name__ == '__main__':
    main()
