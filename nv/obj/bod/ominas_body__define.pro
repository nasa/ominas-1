;=============================================================================
; ominas_body::init
;
;=============================================================================
function ominas_body::init, ii, crd=crd0, bd=bd0, $
@body__keywords.include
end_keywords
@core.include
 
 void = self->ominas_core::init(ii, crd=crd0, $
@core__keywords.include
end_keywords)
 if(keyword_set(bd0)) then struct_assign, bd0, self

 self.abbrev = 'BOD'

 self.opaque = 1
 if(defined(opaque)) then self.opaque = decrapify(opaque[ii])
 if(keyword_set(time)) then self.time = decrapify(time[ii])
 if(keyword_set(pos)) then self.pos = pos[*,*,ii]
 if(keyword_set(vel)) then self.vel[0:(size(vel))[1]-1,*] = vel[*,*,ii]
 if(keyword_set(avel)) then self.avel[0:(size(avel))[1]-1,*] = avel[*,*,ii]
 if(keyword_set(libv)) then self.libv[0:(size(libv))[1]-1,*] = libv[*,*,ii]
 if(keyword_set(dlibdt)) then self.dlibdt[0:(size(dlibdt))[1]-1] = dlibdt[*,ii]
 if(keyword_set(lib)) then self.lib[0:(size(lib))[1]-1] = lib[*,ii]

 if(NOT keyword_set(orient)) then self.orient = idgen(3) $
 else self.orient = orient[*,*,ii]

 self.orientT = transpose(self.orient) 


 return, 1
end
;=============================================================================



;=============================================================================
;+
; NAME:
;	ominas_body__define
;
;
; PURPOSE:
;	Class structure for the BODY class.
;
;
; CATEGORY:
;	NV/LIB/BOD
;
;
; CALLING SEQUENCE:
;	N/A 
;
;
; FIELDS:
;	crd:	CORE class descriptor.  
;
;		Methods: bod_core
;
;
;	opaque:	Flag describing whether a body is "easily visible".  
;
;		Methods: bod_opaque, bod_set_opaque
;
;
;	arrays_tlp: Pointer to a arrays of body-frame points, maintained in the 
;		   file given by array_fname. 
;
;			Methods: bod_array, bod_set_array
;
;
;	array_fnames: String giving the names for the each points file. 
;
;			Methods: bod_array_fname, bod_set_array_fname
;
;
;	time:	Time, at body position, at which this descriptor is valid.
;
;		Methods: bod_time, bod_set_time
;
;
;	orient:	Orientation matrix, transforms body to inertial.
;
;		Methods: bod_orient, bod_set_orient
;
;
;	avel:	Angular velocity vector.  Each higher-order vector is the 
;		angular velocity for the vector of the preceding order.
;
;		Methods: bod_avel, bod_set_avel
;
;
;	pos:	Position of body center in the inertial frame.
;
;		Methods: bod_pos, bod_set_pos
;
;
;	vel:	Velocity of body center in the inertial frame.
;
;		Methods: bod_vel, bod_set_vel
;
;
;	libv:	Libration vector.  Each higher-order vector is the libration 
;		for the vector of the preceding order.  The body librates about
;		the direction v_unit(libv), with an amplitude given by 
;		v_mag(libv).
;
;		Methods: bod_libv, bod_set_libv
;
;
;	lib:	Phase of the libraton vectors at body time.  
;
;		Methods: bod_lib, bod_set_lib
;
;
;	dlibdt:	Frequency for each libration vector.
;
;		Methods: bod_dlibdt, bod_set_dlibdt
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
;=============================================================================
pro ominas_body__define

 ndv=bod_ndv()

 struct = $
    { ominas_body, inherits ominas_core, $
	opaque:		 0b, $			; If set, then this body is
						;  "easily visible".
	arrays_tlp:	 nv_ptr_new(), $	; Pointer to body-frame points 
						; arrays
	time:		 double(0), $		; time at which this descriptor
						; is valid at body position
	orient:		 dblarr(3,3), $		; transforms body->inertial
	orientT:	 dblarr(3,3), $		; transpose of orient matrix

	avel:		 dblarr(ndv,3), $	; angular velocites -- each
						;  higher-order avel is the
						;  ang. vel. for the avel of
						;  the preceding order.

	; note -- body libration currently disabled; see _bod_evolve
	libv:		 dblarr(ndv,3), $	; libration vectors -- each 
						;  higher-order libv is the
						;  libration for the libv of
						;  the preceding order.  Magnitude
						;  gives the amplitude.
	lib:		 dblarr(ndv), $		; libration phase
	dlibdt:		 dblarr(ndv), $		; libration frequency

	pos:		 dblarr(1,3), $		; position of body center
	vel:		 dblarr(ndv,3) $	; velocity and derivatives
    }

end
;===========================================================================


