;=============================================================================
; dh_read_png.pro
;
;=============================================================================
function dh_read_png, dd, label, dim, type, min, max, abscissa=abscissa, $
                          nodata=nodata, gff=gff, $
                          sample=sample, returned_samples=returned_samples

 if(keyword_set(sample)) then return, 0
 filename = dat_filename(dd)

min=0
max=0
;read the image
da=double(read_png(filename))
;read the metadata
filename_ja=(stregex(filename,'(.*)-raw\.png',/subexpr,/extract))[-1]+'.json'
label=json_parse(filename_ja)
label[0]='' ;dummy key to make detectors that assume label is a string array happy
type=size(da,/type)
nax=size(da,/n_dimensions)
dim=size(da,/dimensions)
if idl_validname(label['INSTRUMENT_NAME'],/convert_all) eq 'JUNO_EPO_CAMERA' then begin
  nframes=label['LINES']/128
  da=reverse(da,2,/overwrite)
  da=reform(da,[dim[0],128,nframes],/overwrite)
  ;da=reverse(da,2,/overwrite)
  da=da[23:1630,*,*] ;cut off overscan
  nax=size(da,/n_dimensions)
  dim=size(da,/dimensions)
endif

return,da
end
;=============================================================================