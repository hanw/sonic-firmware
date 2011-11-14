/*
 * debug.c
 *
 *  Created on: Aug 15, 2011
 *      Author: hwang
 */

#include "debug.h"
#include <stdio.h>

extern int msglevel; /* the higher, the more messages... */

void debug_printf (char *format, va_list ap) {

	vfprintf( stderr, format, ap);
}

#if defined(NDEBUG) && defined(__GNUC__)
/* Nothing. pmesg has been "defined away" in debug.h already. */
#else
void pmesg(int level, char* format, ...) {
#ifdef NDEBUG
	/* Empty body, so a good compiler will optimise calls
	   to pmesg away */
#else
        va_list args;

        if (level>msglevel)
                return;

        va_start(args, format);

        debug_printf(format, args);

        va_end(args);
#endif /* NDEBUG */
#endif /* NDEBUG && __GNUC__ */
}
