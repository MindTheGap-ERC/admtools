is_destructive = function(adm, t){
  #'
  #' @title Is deposition destructive?
  #' 
  #' @param adm an adm object
  #' @param t vector of times
  #' 
  #' @returns logical vector of same length as t. Is deposition at time t destructive?
  #' 
  is_destructive = as.logical(approx(x = adm$t,
                          y = c(adm$destr,adm$destr[length(adm$destr)]),
                          method = "constant",
                          ties = "ordered",
                          xout = t)$y)
  return(is_destructive)
}
