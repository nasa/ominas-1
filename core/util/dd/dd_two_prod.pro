;==============================================================================
; dd_two_prod
;
;  See Hida et al. 2000
;
;==============================================================================
function dd_two_prod, a, b, e=e

 p = a*b
 aa = dd_split(a)
 bb = dd_split(b)

 n = n_elements(aa)/2
 
 a0 = aa[0:n-1]
 a1 = aa[n:*]

 b0 = bb[0:n-1]
 b1 = bb[n:*]


 e = ((a0*b0-p) + a0*b1 + a1*b0) + a1*b1

 return, p
end
;==============================================================================