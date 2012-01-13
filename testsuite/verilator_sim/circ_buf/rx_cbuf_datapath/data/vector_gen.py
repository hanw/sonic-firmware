from bitstream import *
from bitstring import *
import string

conv_64_to_40('../../../scripts/test_vector.dat', 'test_vector.dat')

conv_64_to_page('../../../scripts/test_vector.dat', 'test_vector.page')

conv_page_to_66('test_vector.page', 'test_vector.66b')
conv_64_to_66('../../../scripts/test_vector.dat', 'ref_66.dat')
