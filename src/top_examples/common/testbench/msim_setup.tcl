
# -----------------------------------------
# simulation script

# -----------------------------------------
# Initialize the variable

if ![info exist SONIC_COMMON_SRCDIR] { 
   set SONIC_COMMON_SRCDIR "."
} elseif { ![ string match "" $SONIC_COMMON_SRCDIR ] } { 
   set SONIC_COMMON_SRCDIR "$SONIC_COMMON_SRCDIR"
} 

# -----------------------------------------
# Compile the design files in correct order
alias sonic_common_com {
	set simlist [open $SONIC_COMMON_SRCDIR/src_filelist r]
	while {[gets $simlist vfile] >= 0} {
		vlog +incdir+$SONIC_COMMON_SRCDIR+. $SONIC_COMMON_SRCDIR/$vfile
	}
	close $simlist
}

