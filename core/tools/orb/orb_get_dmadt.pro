;===========================================================================
; orb_get_dmadt
;
;
;===========================================================================
function orb_get_dmadt, xd, void
 return, cor_udata(xd, 'dmadt')
end
;===========================================================================