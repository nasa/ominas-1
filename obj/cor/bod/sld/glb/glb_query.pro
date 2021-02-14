;=============================================================================
;+
; NAME:
;	glb_query
;
;
; PURPOSE:
;	Returns the fields associated with a GLOBE object.  This is a 
;	convenient way of getting multiple fields in one call, and only a 
;	single event is generated.
;
;
; CATEGORY:
;	NV/OBJ/GLB
;
;
; CALLING SEQUENCE:
;	glb_query, gbd, <keywords>=<values>
;
;
; ARGUMENTS:
;  INPUT:
;	gbd:	GLOBE object.
;
;  OUTPUT: NONE
;
;
; KEYWORDS:
;  INPUT: 
;	<keywords>:	GLOBE object fields to set.
;
;	condition:	Structure specifing a mask and a condition with which to
;			match flag values.  The structure must contain the fields
;			MASK and STATE.  MASK is a bitmask to test against
;			the flags field of the POINT object, and STATE
;			is either PS_TRUE and PS_FALSE.  Note that in this case, 
;			the values will be returned as a list, with no separation 
;			into nv and nt dimensions.
;
;	cat:		If set, arrays from mulitple input objets are 
;			concatenated.
;
;	<condition>:	All of the predefined conditions (e.g. /visible) are 
;			accepted; see pnt_condition_keywords.include.
;
;	noevent:	If set, no event is generated.
;
;  OUTPUT: NONE
;
;
; STATUS:
;	Complete
;
;
;
; MODIFICATION HISTORY:
; 	Written by:	Spitale, 2/2017
;	
;-
;=============================================================================
pro glb_query, xd, condition=condition, cat=cat, noevent=noevent, $
@glb__keywords_tree.include
end_keywords

 nv_notify, xd, type = 1, noevent=noevent
 _xd = cor_dereference(xd)
_xd=xd

@glb_query.include

end
;===========================================================================