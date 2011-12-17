import os, sys
cmd_folder = os.path.dirname(os.path.abspath("../../../../lib_module/scripts/bitstream.py"))
if cmd_folder not in sys.path:
    sys.path.insert(0, cmd_folder)

from bitstream import *

# convert output bin40 to bitstream
conv_bin66_to_bitstream('bsync.dat', 'bsync.bit')

conv_64_to_bitstream('../../../../lib_module/scripts/test_vector.dat', 'ref.bit')


