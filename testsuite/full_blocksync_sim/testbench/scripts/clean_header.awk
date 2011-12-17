# check $1 in all lines until we have find 0,
# remove \n in the current line, if we haven't found
# a line start with $1 = 0
#OUTPUT = "log.out";
# tidy up header line
{sub(/delta/, "")}
{sub(/ps/, "ps delta")}
# if the current line does not start with a number, we assume it is part of the header line
# thus, we remove the newline charactor from it.
{
	if($1 !~ /^[0-9]+/){
		{sub(/$/, ""); printf ("%s ",$0) > OUTPUT}
	}
	else{
		# find the first data record, insert a newline before it
		if ($1 ~ /^0/ && $2 ~ /+0/){
			{printf ("\n") > OUTPUT}
		}
		# copy the data record
		{print $0 > OUTPUT}
	}
}
