head -n 10000 list.lst | nawk '{ if ( $3 == "St1") print $4 }' > output.dat

python prepare_data.py

head -n 4000 ref.hex > ref_trim.hex

head -n 80000 output.bit > head_output.bit
head -n 82000 output_ref.bit > head_ref.bit
