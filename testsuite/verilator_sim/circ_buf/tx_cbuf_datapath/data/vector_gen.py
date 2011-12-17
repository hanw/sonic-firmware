# 
#
#
import string
from bitstring import *
from bitstream import *

tmp='/tmp/tx_cbuf.tmp'
conv_64_to_page ('../../../scripts/test_vector.dat', tmp)

fpage = open(tmp, 'r')
fout = open('test_vector.dat', 'w')

lines = sum(1 for line in fpage)
fpage.seek(0)

for n in range(lines):
    l = fpage.readline()
    fout.write(l[0:len(l)/2])
    fout.write(' ')
    fout.write(l[len(l)/2:len(l)-1])
    fout.write(' ')
    fout.write(str(hex(n % 0x3E00))[2:])
    fout.write('\n')
fpage.close()
fout.close()
 
conv_64_to_66 ('../../../scripts/test_vector.dat', 'test_ref.hex')

