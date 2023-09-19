as_adm = function(t, h, destr_stasis = TRUE, T_unit = NA,L_unit = NA){
  #'
  #'
  if(destr_stasis){
    destructive = duplicated(h)[2:length(h)]
  } else {
    destructive = rep(FALSE, length(t) - 1)
  }
  
  adm = list(t = t,
             h = h,
             destr = destructive,
             T_unit = T_unit,
             L_unit = L_unit)
  class(adm) = "adm"
  return(adm)
}
