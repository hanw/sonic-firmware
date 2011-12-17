import os, sys
cmd_folder = os.path.dirname(os.path.abspath("../../../../lib_module/scripts/bitstream.py"))
if cmd_folder not in sys.path:
    sys.path.insert(0, cmd_folder)

from bitstream import *

# convert output bin40 to bitstream
conv_bin40_to_bitstream('output.dat', 'output.bit')

# convert reference input to bitstream
conv_bits_to_hex('output.dat', 'output.hex')

conv_64_to_bitstream('../../../../lib_module/scripts/test_vector.dat', 'output_ref.bit')

