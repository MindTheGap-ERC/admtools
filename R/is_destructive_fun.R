is_destructive_fun = function(adm){
  fun = function(x) as.logical(approx(x = adm$t,
                                      y = c(adm$destr,adm$destr[length(adm$destr)]),
                                      method = "constant",
                                      ties = "ordered",
                                      xout = x)$y)
  return(fun)
}
