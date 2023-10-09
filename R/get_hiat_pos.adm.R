get_hiat_pos.adm = function(x){
  #'
  #'@export
  
  adm = x
  
  hiat_pos = unique(adm$h[duplicated(adm$h)])
  
  return(hiat_pos)
}
