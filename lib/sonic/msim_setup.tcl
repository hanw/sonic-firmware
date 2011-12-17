
# -----------------------------------------
# simulation script

# -----------------------------------------
# Initialize the variable

if ![info exist SONIC_SPEC_SRCDIR] { 
   set SONIC_SPEC_SRCDIR "."
} elseif { ![ string match "" $SONIC_SPEC_SRCDIR ] } { 
   set SONIC_SPEC_SRCDIR "$SONIC_SPEC_SRCDIR"
} 

# -----------------------------------------
# Compile the design files in correct order
alias sonic_spec_com {
	set simlist [open $SONIC_SPEC_SRCDIR/src_filelist r]
	while {[gets $simlist vfile] >= 0} {
		vlog +define+SYNTHESIS=1 +incdir+$SONIC_SPEC_SRCDIR+. $SONIC_SPEC_SRCDIR/$vfile
	}
	close $simlist
}

