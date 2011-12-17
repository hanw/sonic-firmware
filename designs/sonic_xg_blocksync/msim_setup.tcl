
# -----------------------------------------
# simulation script

# -----------------------------------------
# Initialize the variable

if ![info exist SONIC_DES_SRCDIR] { 
   set SONIC_DES_SRCDIR "."
} elseif { ![ string match "" $SONIC_DES_SRCDIR ] } { 
   set SONIC_DES_SRCDIR "$SONIC_DES_SRCDIR"
} 

# -----------------------------------------
# Compile the design files in correct order
alias sonic_des_com {
	set simlist [open $SONIC_DES_SRCDIR/src_filelist r]
	while {[gets $simlist vfile] >= 0} {
		vlog +incdir+$SONIC_DES_SRCDIR+. $SONIC_DES_SRCDIR/$vfile
	}
	close $simlist
}

