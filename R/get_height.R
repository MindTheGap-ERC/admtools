get_height = function(adm, t, destructive = TRUE){
  height = approx(x = adm$t,
                  y = adm$h,
                  xout = t)$y
  if (destructive){
    destr_fun = is_destructive_fun(adm)
    is_destr = destr_fun(t)
    height[is_destr] = NA
  }
  
  return(height)
}