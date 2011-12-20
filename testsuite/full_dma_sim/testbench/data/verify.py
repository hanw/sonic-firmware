import string

def conv_136_to_128 (file_in, file_out):
    ftmp = open(file_in, 'r')
    lines = sum(1 for line in ftmp)
    ftmp.seek(0)
    fbits = open(file_out, 'w')
    for n in range (lines):
        l = ftmp.readline()
        val = string.index(l,' ');
        time = l[0:val];
        lbits = l[val+8:]
        fbits.write(time + ' ' +  lbits)
    ftmp.close()
    fbits.close()
    print('Done!\n')

def conv_bits_to_hex (file_in, file_out):
    ftmp = open(file_in, 'r')
    lines = sum(1 for line in ftmp)
    ftmp.seek(0)
    fbits = open(file_out, 'w')
    for n in range (lines):
        l = ftmp.readline()
        val = string.index(l,' ');
        time = l[0:val];
        lbits = int(l[val:], 2)
        fbits.write(time + ' ' +  "%032x"%lbits + '\n')
    ftmp.close()
    fbits.close()
    print('Done!\n')

conv_136_to_128("rp_after_combine_ctrl_module.lst", "rp_after_combine_ctrl_module.bits")
conv_bits_to_hex("rp_after_combine_ctrl_module.bits", "rp_after_combine_ctrl_module.hex")

#conv_136_to_128("rp_desc.lst", "rp_desc.bits")
#conv_bits_to_hex("rp_desc.bits", "rp_desc.hex")
#conv_bits_to_hex("app0_desc.lst", "app0_desc.hex")
#conv_bits_to_hex("app1_desc.lst", "app1_desc.hex")

