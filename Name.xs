/* $Id: Name.xs,v 1.5 2004/08/18 13:21:44 xmath Exp $
 * Copyright (C) 2004  Matthijs van Duin.  All rights reserved.
 * This program is free software; you can redistribute it and/or modify 
 * it under the same terms as Perl itself.
 */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifdef USE_5005THREADS
#error "Not compatible with 5.005 threads"
#endif

MODULE = Sub::Name  PACKAGE = Sub::Name

PROTOTYPES: DISABLE

void
subname(name, sub)
	char *name
	SV *sub
    PREINIT:
	CV *cv = NULL;
	GV *gv;
	HV *stash = CopSTASH(PL_curcop);
	char *s, *end = NULL, saved;
    PPCODE:
	if (!SvROK(sub) && SvGMAGICAL(sub))
		mg_get(sub);
	if (SvROK(sub))
		cv = (CV *) SvRV(sub);
	else if (SvTYPE(sub) == SVt_PVGV)
		cv = GvCVu(sub);
	else if (!SvOK(sub))
		croak(PL_no_usym, "a subroutine");
	else if (PL_op->op_private & HINT_STRICT_REFS)
		croak(PL_no_symref, SvPV_nolen(sub), "a subroutine");
	else if ((gv = gv_fetchpv(SvPV_nolen(sub), FALSE, SVt_PVCV)))
		cv = GvCVu(gv);
	if (!cv)
		croak("Undefined subroutine %s", SvPV_nolen(sub));
	if (SvTYPE(cv) != SVt_PVCV && SvTYPE(cv) != SVt_PVFM)
		croak("Not a subroutine reference");
	for (s = name; *s++; ) {
		if (*s == ':' && s[-1] == ':')
			end = ++s;
		else if (*s && s[-1] == '\'')
			end = s;
	}
	s--;
	if (end) {
		saved = *end;
		*end = 0;
		stash = GvHV(gv_fetchpv(name, TRUE, SVt_PVHV));
		*end = saved;
		name = end;
	}
	gv = (GV *) newSV(0);
	gv_init(gv, stash, name, s - name, TRUE);
	av_store((AV *) AvARRAY(CvPADLIST(cv))[0], 0, (SV *) gv);
	CvGV(cv) = gv;
	PUSHs(sub);
