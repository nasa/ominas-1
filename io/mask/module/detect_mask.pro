;===========================================================================
; detect_mask.pro
;
;===========================================================================
function detect_mask, filename=filename, header=header

 status = 0

 ;===============================================
 ; if no header, read the beginning of the file
 ;===============================================
 if(keyword_set(header)) then s = header $
 else $
  begin
   openr, unit, filename, /get_lun, error=error
   if(error NE 0) then return, 0
   if((fstat(unit)).size LT 4) then return, 0
   record = assoc(unit, bytarr(4,/nozero))
   s = string(record[0])
   close, unit
   free_lun, unit
  end



 ;===================================
 ; check for indicator string
 ;===================================
 if ~isa(s,'string') then return,0
 if(s[0] EQ 'mask') then status=1


 return, status
end
;===========================================================================