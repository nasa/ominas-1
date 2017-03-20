;=============================================================================
;+
; NAME:
;	dat_output_keyvals
;
;
; PURPOSE:
;	Returns the maintenance value associated with a data descriptor.
;
;
; CATEGORY:
;	NV/OBJ/DAT
;
;
; CALLING SEQUENCE:
;	data = dat_output_keyvals(dd)
;
;
; ARGUMENTS:
;  INPUT:
;	dd:	Data descriptor.
;
;  OUTPUT: NONE
;
;
; KEYWORDS:
;  INPUT: NONE
;
;  OUTPUT: NONE
;
;
; RETURN:
;	The maintenance value associated with the data descriptor.
;
;
; STATUS:
;	Complete
;
;
;
; MODIFICATION HISTORY:
; 	Written by:	Spitale, 7/2008
; 	Adapted by:	Spitale, 5/2016
;	
;-
;=============================================================================
function dat_output_keyvals, dd, noevent=noevent
@core.include
 nv_notify, dd, type = 1, noevent=noevent
 _dd = cor_dereference(dd)
 return, *_dd.output_keyvals_p
end
;===========================================================================


