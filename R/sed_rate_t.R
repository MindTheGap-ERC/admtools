sed_rate_t = function(x, t, mode = "rcll"){
  #' @title sedimentation rate in time domain
  #'  
  #' @description
    #' infers the instantaneous sedimentation rate from adm objects
  #'
  #' @param x adm or multiadm object
  #' @param t vector of times at which sedimentation rates are determined
  #' @param mode string, "rcll" or "lcrl". at non-differential points, is the sed rate left or right continuous?
  #' 
  #' @returns for adm objects, a vector giving sed. accumulation rates at time t. For multiadm objects, a list with accumulation rates
  UseMethod("sed_rate_t")
}

sed_rate_t.adm = function(x, t, mode = "rcll"){
  val = diff(x$h)/diff(x$t)
  borders = x$t
  if (mode == "rcll"){
    srate = approx(x = borders, y = c(val, val[length(val)]), xout = t,  method = "constant", f = 0)$y
    return(srate)
  }
  if (mode == "lcrl"){
    srate = approx(x = borders, y = c(val, val[length(val)]), xout = t, method = "constant", f = 1)$y
    return(srate)
  }
  stop("unrecognized mode. Use \'rcll\' or \'lcrl\'.")
}

sed_rate_t.multiadm = function(x,t,mode){
  
  adm_list = split_multiadm(x)
  
  h_list = lapply(adm_list, function(x) sed_rate_t.adm(x,t,mode))
  return(h_list)
}

#x = tp_to_adm(1:4, c(2,3,3,4))

sed_rate_t_fun = function(x, mode = "rcll"){
  
  if (!is_adm(x)){
    stop("Please use an adm object")
  }
  val = diff(x$h)/diff(x$t)
  borders = x$t
  if (mode == "rcll"){
    f = approxfun(x = borders, y = c(val, val[length(val)]),  method = "constant", f = 0)
    return(f)
  }
  if (mode == "lcrl"){
    f = approxfun(x = borders, y = c(val, val[length(val)]), method = "constant", f = 1)
    return(f)
  }
  stop("unrecognized mode. Use \'rcll\' or \'lcrl\'.")
}
