is_destructive = function(adm, t, mode = "rcll"){
  #'
  #' @title Is deposition destructive?
  #' 
  #' @param adm an adm object
  #' @param t vector of times
  #' 
  #' @returns logical vector of same length as t. Is deposition at time t destructive?
  #' 
  if (mode == "rcll"){
    is_destructive = as.logical(approx(x = adm$t,
                                       y = c(adm$destr,adm$destr[length(adm$destr)]),
                                       method = "constant",
                                       ties = "ordered",
                                       f = 0,
                                       xout = t)$y)
    return(is_destructive)
  }
  if (mode == "lcrl") {
    is_destructive = as.logical(approx(x = adm$t,
                                       y = c(adm$destr[1],adm$destr),
                                       method = "constant",
                                       ties = "ordered",
                                       f = 1,
                                       xout = t)$y)
    return(is_destructive)
  }
  
  if (mode == "open") {
    is_destructive = is_destructive(adm = adm, t = t, mode = "rcll") & is_destructive(adm = adm, t = t, mode = "lcrl")
    return(is_destructive)
  }
  
  if (mode == "closed") {
    is_destructive = is_destructive(adm = adm, t = t, mode = "rcll") | is_destructive(adm = adm, t = t, mode = "lcrl")
    return(is_destructive)
  }

stop("unknown mode")


}
