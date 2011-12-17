head -n 10000 $1 | nawk '{ print $3 }' > $2


