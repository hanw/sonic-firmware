#
# convert input file to bitstream.
# Author: Han Wang
# Date: 11/22/2011
from bitstream import *
from bitstring import *

f = open('test_vector.40b', 'r')
fb = open('/tmp/test_vector.bin', 'w')

for line in f:
    val_bin = BitString(uint=int(line,16), length=40)
    val_bin.reverse()
    for bit in range(40):
        fb.write(val_bin.bin[bit+2] + '\n')
f.close()
fb.close()

fr = open('result.hex', 'r')
frb = open('/tmp/test_result.bin', 'w')
frr = open('/tmp/test_result_ref.bin', 'w')
for line in fr:
    val_bin = BitString(uint=int(line,16), length=66)
    ref = hex(int(val_bin.bin, 2))
    val_bin.reverse()
    for bit in range(66):
        frb.write(val_bin.bin[bit+2] + '\n')
        frr.write(val_bin.bin[bit+2])
        if(bit == 0):
            frr.write( "     " + "#" + ref)
        frr.write('\n')
fr.close()
frb.close()


