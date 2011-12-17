#
# convert input file to bitstream.
# Author: Han Wang
# Date: 11/22/2011

from bitstring import *

# Convert Hex to Binary
f = open ('/tmp/actual_test_vector.dat', 'r')
fb = open ('/tmp/actual_test_vector.bin', 'w')
for line in f:
    val_bin = BitString(uint=int(line, 16),length=64)
    for n in range (64):
        fb.write(val_bin.bin[65-n] + '\n')
fb.write("\n")
f.close()
fb.close()

fr = open('/tmp/actual_result.hex', 'r')
frb = open('/tmp/actual_test_result.bin', 'w')
frr = open('/tmp/actual_test_result_ref.bin', 'w')
for line in fr:
    val_bin = BitString(uint=int(line,16), length=40)
    ref = hex(int(val_bin.bin, 2))
    for bit in range(40):
        frb.write(val_bin.bin[40-bit+1] + '\n')
        frr.write(val_bin.bin[40-bit+1])
        if(bit == 0):
            frr.write( "     " + "#" + ref)
        frr.write('\n')
fr.close()
frb.close()
