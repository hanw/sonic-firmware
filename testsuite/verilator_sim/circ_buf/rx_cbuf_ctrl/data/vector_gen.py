from bitstream import *
from bitstring import *
import string

conv_64_to_66 ("../../../scripts/test_vector.dat", "test_vector.dat")

conv_64_to_page ("../../../scripts/test_vector.dat", "test_ref.dat")
