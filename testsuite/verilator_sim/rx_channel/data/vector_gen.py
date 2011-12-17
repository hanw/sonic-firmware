from bitstream import *

conv_64_to_page("../../scripts/test_vector.dat", "test_ref.dat")

conv_64_to_40("../../scripts/test_vector.dat", "test_vector.dat")

conv_64_to_66("../../scripts/test_vector.dat", "test_vector.66b")
