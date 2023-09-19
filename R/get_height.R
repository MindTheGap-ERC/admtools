get_height = function(adm, t, destructive = TRUE){
  height = approx(x = adm$t,
                  y = adm$h,
                  xout = t)$y
  if (destructive){
    is_destr = is_destructive(adm,t)
    height[is_destr] = NA
  }
  
  return(height)
}
