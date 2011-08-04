# This awk script search and output the signals that read xxx(uninitialized)
# Author: Han Wang
NR==1 {
	nf = NF
	for (f=1; f<=NF; f++){
		if($f){
			record[f,0]=$f
			record[f,1]=0
			record[f,2]=0
			record[f,3]=0
		}
	}
	next
}

# Loop through each signal, output the ones with 'xxx'
# NF: number of field in current line
# skip the first 2000 record
NR>1500 {
	for (x=1; x<= NF; x++){
		if($x ~ /x+/){
			record[x,1]++
		}
	
		if($x ~ /HiZ/ || $x ~ /z/){
			record[x,2]++
		}

		if($x ~ /StX/){
			record[x,3]++
		}
	}
}

END{
	print ("Signals that shows xxx:") > RESULT
	for (x=1; x<= nf; x++){
		if (record[x,1] != 0)
			print(x, record[x,1], record[x,0]) > RESULT
	}
	print ("Signals that shows hiz:") > RESULT
	for (x=1; x<= nf; x++){
		if (record[x,2] != 0)
			print(x, record[x,2], record[x,0]) > RESULT
	}
	print ("Signals that shows stx:") > RESULT
	for (x=1; x<= nf; x++){
		if (record[x,3] != 0)
			print(x, record[x,3], record[x,0]) > RESULT
	}
}
# end of find_xxx.awk
