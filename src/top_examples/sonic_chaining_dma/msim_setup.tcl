
# -----------------------------------------
# simulation script

# -----------------------------------------
# Initialize the variable

if ![info exist SONIC_APP_SRCDIR] { 
   set SONIC_APP_SRCDIR "."
} elseif { ![ string match "" $SONIC_APP_SRCDIR ] } { 
   set SONIC_APP_SRCDIR "$SONIC_APP_SRCDIR"
} 

# -----------------------------------------
# Compile the design files in correct order
alias sonic_app_com {
	set simlist [open $SONIC_APP_SRCDIR/src_filelist r]
	while {[gets $simlist vfile] >= 0} {
		vlog +incdir+$SONIC_APP_SRCDIR+. $SONIC_APP_SRCDIR/$vfile
	}
	close $simlist
}

