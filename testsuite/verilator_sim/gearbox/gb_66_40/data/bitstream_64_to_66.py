#
# This script converts bitstream.dat which has 64 bit in a row
# to test_vector.hex which has 66 bit in a row, separate into
# two column, first column has the MSB 64 bits, second column
# has the LSB 2 bits, which is the sync header.
# Author: Han Wang
# Date: 11/14/2011
#

#!/bin/python
import string
from bitstream import *

conv_64_to_66('test_vector.dat', 'test_vector.hex')

'''
# Convert Hex to Binary
f = open ('test_vector.dat', 'r')
fb = open ('test_vector.bin', 'w')
for line in f:
    val_bin = BitString(uint=int(line, 16),length=64)
    for n in range (64):
        fb.write(val_bin.bin[65-n] + '\n')
fb.write("\n")
f.close()
fb.close()

tot_line = len(open("test_vector.bin").readlines())
fb = open ('test_vector.bin', 'r')

# chop to 66 bit segments start with the first bit
fnew = open('test_vector.66b', 'w')
for n in range(tot_line/66):
    data = ""
    for m in range (66):
        data = fb.readline()[0] + data
    fnew.write(data)
    fnew.write("\n")
fnew.close()
fb.close()

# Convert back to Hex
ffinal = open('test_vector.hex', 'w')
f66 = open('test_vector.66b', 'r')
for line in f66:
    hbits = '%0x' % (int(line[0:2],2))
    ffinal.write(hbits)
    ffinal.write(" ")
    lbits = '%016x' % (int(line[2:66], 2))
    ffinal.write(lbits)
    ffinal.write("\n")
f66.close()
ffinal.close()
'''
