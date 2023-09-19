as_adm = function(t, h, destr_stasis = TRUE){
  if(destr_stasis){
    destructive = duplicated(h)[2:length(h)]
  } else {
    destructive = rep(FALSE, length(t) - 1)
  }
  
  adm = list(t = t,
             h = h,
             destr = destructive)
  class(adm) = "adm"
  return(adm)
}