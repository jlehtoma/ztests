#!/usr/bin/env python
# -*- coding: utf-8 -*-

import glob
import os
import sys

import gdal
from gdalconst import *
import numpy


def compare_rasters(raster_dataset_1, raster_dataset_2, tolerance=1e-08):
    ''' Compares the values of two rasters given a certain treshold.

    The default tolerance value is the same as the one used by numpy.allclose.

    @param raster_dataset_1 GDAL dataset
    @param raster_dataset_2 GDAL dataset
    @param tolerance double defining the raster similarity tolerance (see http://docs.scipy.org/doc/numpy/reference/generated/numpy.allclose.html)
    @return equal boolean indicating if the raster values are the same (or similar enough)
    '''

    print("INFO: Extracting bands from the first dataset...")
    band_1 = raster_dataset_1.GetRasterBand(1)
    print("INFO: Extracting bands from the second dataset...")
    band_2 = raster_dataset_2.GetRasterBand(1)

    print("INFO: Extracting band 1 from the first dataset...")
    data_1 = band_1.ReadAsArray(0, 0, raster_dataset_1.RasterXSize,
                                raster_dataset_1.RasterYSize).astype(numpy.float)
    print("INFO: Extracting band 1 from the second dataset...")
    data_2 = band_2.ReadAsArray(0, 0, raster_dataset_2.RasterXSize,
                                raster_dataset_2.RasterYSize).astype(numpy.float)

    print("INFO: Comparing values...")
    equal = numpy.allclose(data_1, data_2, atol=tolerance)
    return equal


def raster_pairs(folder1, folder2, suffix='', ext=''):
    ''' Scan two Zonation output folders and search for raster files with the same name.

    Additional arguments can be provided to define a known filename suffix and/or extension.

    @param folder1 String path to first folder
    @param folder2 String path to second folder
    @return list of tuples (pairs of paths in the two folders)
    '''

    pattern = '*' + suffix + ext

    rasters_1 = glob.glob(os.path.join(folder1, pattern))
    if len(rasters_1) == 0:
        print('ERROR: No suitable files (pattern: {0}) found in folder 1'.format(pattern))
        sys.exit(0)

    rasters_2 = glob.glob(os.path.join(folder2, pattern))
    if len(rasters_2) == 0:
        print('ERROR: No suitable files (pattern: {0}) found in folder 2'.format(pattern))
        sys.exit(0)

    # FIXME: what if the lists are different lenghts?
    return zip(rasters_1, rasters_2)

folder_1 = '/home/jlehtoma/opt/zonation-3.1.9-GNU-Linux/ESMK/analyysi/15_60_5kp_abf_pe/output/'
folder_2 = '/home/jlehtoma/opt/zonation-3.1.9-GNU-Linux/ESMK/analyysi/15_60_5kp_abf_pe_WIN/output/'

pairs = raster_pairs(folder_1, folder_2, suffix='.rank.*', ext='.img')

comparisons = []

for pair in pairs:
    print("INFO: Reading in Linux result dataset...")
    raster_dataset1 = gdal.Open(pair[0], GA_ReadOnly)
    print("INFO: Reading in Windows result dataset...")
    raster_dataset2 = gdal.Open(pair[0], GA_ReadOnly)

    comparisons.append(compare_rasters(raster_dataset1, raster_dataset1))

if all(comparisons):
    print("INFO: All values in all pairs seem to be the same")
else:
    print("WARNING: Some pairs seem to differ")
    for i, item in enumerate(comparisons):
        if not comparisons[i]:
            print(item)
