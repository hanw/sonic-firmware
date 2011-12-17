
# -----------------------------------------
# simulation script

# -----------------------------------------
# Initialize the variable

if ![info exist SONIC_LIB_SRCDIR] { 
   set SONIC_LIB_SRCDIR "."
} elseif { ![ string match "" $SONIC_LIB_SRCDIR ] } { 
   set SONIC_LIB_SRCDIR "$SONIC_LIB_SRCDIR"
} 

# -----------------------------------------
# Compile the design files in correct order
alias sonic_lib_com {
	set simlist [open $SONIC_LIB_SRCDIR/src_filelist r]
	while {[gets $simlist vfile] >= 0} {
		vlog +incdir+$SONIC_LIB_SRCDIR+. $SONIC_LIB_SRCDIR/$vfile
	}
	close $simlist
}

