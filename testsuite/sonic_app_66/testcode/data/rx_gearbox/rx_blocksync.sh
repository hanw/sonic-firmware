head -n 10000 $1 | nawk '{ if ( $3 == 1 ) print $4 }' > $2


