# 
# This script generate a stream of memory write address and data in column 1 & 2
# It also generate the read address at column 3.
#
import string
import random

n_lines = 200

f = open('test_vector.dat', 'w')

for n in range(n_lines):
    f.write(str(hex(n))[2:])
    f.write(' ')
    f.write(random.choice('01'))
    f.write(random.choice('01'))
    f.write(' ')
    f.write(str(hex(n/64))[2:])
    f.write('\n')

for n in range(n_lines):
    # Write write_address
    f.write(random.choice('012345678'))
    for i in range (3):
        f.write(random.choice('0123456789ABCDEF'))
    f.write(' ')
    # Write binary data
    for i in range (2):
        f.write(random.choice('01'))
    f.write(' ')
    # Write read_address 10bits
    f.write(random.choice('0123'))
    for i in range (2):
        f.write(random.choice('0123456789ABCDEF'))
    f.write('\n')
f.close()
