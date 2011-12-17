# 
# This script generate a stream of memory write address and data in column 1 & 2
# It also generate the read address at column 3.
#
import string
import random

n_lines = 600

f = open('test_vector.dat', 'w')

for n in range(n_lines):
    # Write data_in
    for i in range (16):
        f.write(random.choice('0123456789ABCDEF'))
    f.write(' ')
    for i in range (16):
        f.write(random.choice('0123456789ABCDEF'))
    f.write(' ')
    # Write read_address 15bits
    f.write(str(hex(n)[2:]))
    f.write(' ')
    f.write(str(hex(n)[2:]))
    f.write('\n')

f.close()
