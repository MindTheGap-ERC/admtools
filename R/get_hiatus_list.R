get_hiatus_list = function(adm){
  hiat_pos = adm$h[duplicated(adm$h)]
  hiat_start = sapply(hiat_pos, function(x) min(adm$t[adm$h == x]))
  hiat_end = sapply(hiat_pos, function(x) min(adm$t[adm$h == x]))
  
  
}