;===========================================================================
;+
; NAME:
;	glb_hide_points_limb
;
;
; PURPOSE:
;	Hides points lying on the surface of a GLOBE object that are 
;	obscured by the limb with respect to a given viewpoint.  This 
;	procedure is much faster then the more general glb_hide_points.
;
;
; CATEGORY:
;	NV/LIB/GLB
;
;
; CALLING SEQUENCE:
;	sub = glb_hide_points_limb(gbd, view_pts, hide_pts)
;
;
; ARGUMENTS:
;  INPUT: 
;	gbd:		Array (nt) of any subclass of GLOBE descriptors.
;
;	view_pts:	Columns vector giving the BODY-frame position of the viewer.
;
;	hide_pts:	Array (nv) of BODY-frame vectors giving the points to hide.
;
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
;	Subscripts of the points in p that are hidden by the object.  
;	Note that this routine is only valid for points that lie on
;	the surface of the globe.  This routine is faster than
;	glb_hide_points.
;
;
; STATUS:
;	Complete
;
;
; MODIFICATION HISTORY:
; 	Written by:	Spitale, 1/1998
; 	Adapted by:	Spitale, 5/2016
;	
;-
;===========================================================================
function glb_hide_points_limb, gbd, view_pts, hide_pts
@core.include
 

 nt = n_elements(gbd)
 nv = (size(hide_pts))[1]

 ray_pts = v_unit(hide_pts - view_pts[gen3y(nv,3,nt)])
 norm_pts = glb_get_surface_normal(/body, gbd, hide_pts)

 sub = where(v_inner(norm_pts,ray_pts) GT 0)

 return, sub
end
;===========================================================================