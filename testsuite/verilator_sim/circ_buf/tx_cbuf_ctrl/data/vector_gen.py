import string
from bitstring import *
from bitstream import *

conv_64_to_page ("../../../scripts/test_vector.dat", "test_vector.page")

fp = open ("test_vector.page", "r")
fout = open ("test_vector.dat", 'w')
n = 0
for line in fp:
    if (n >= 0x2000):
        n = 0
    fout.write(line[0:len(line)/2] + ' ' + line[len(line)/2:len(line)-1] + ' ' + hex(n)[2:] + '\n')
    n = n + 1
fp.close()
fout.close()

conv_64_to_66 ("../../../scripts/test_vector.dat", "test_ref.dat")
