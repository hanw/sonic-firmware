head -n 10000 list.lst | nawk '{ print $3 }' > output.dat

python prepare_data.py

head -n 80000 output.bit > head_output.bit
head -n 82000 output_ref.bit > head_ref.bit
