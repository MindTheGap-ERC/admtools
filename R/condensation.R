condensation = function(x, h, mode = "rcll", ...){
  #' @export
  #' 
  #' @title condensation with height
  #' 
  #' @description
    #' returns (instantaneous) condensation (time preserved per length increment) for a section
    #' 
  #' @param x adm or multiadm object
  #' @param h numeric vector, positions where condensation is determined
  #' @param mode string, handed over to _sed_rate_t_, see ?sed_rate_t for details
  #' @param ... parameters passed to _get_time_, see ?get_time for details
  #' 
  #' @returns if x is an adm object, a numeric vector of condensations. if x is a multiadm object, a list of condensations
  
  UseMethod("condensation")
  
}

condensation.adm = function(x, h, mode = "rcll", ...){
  #' @export
  srate = sed_rate_l.adm(x,h,mode, ...)
  cond = 1/srate
  return(cond)
}

condensation.multiadm = function(x, h, mode = "rcll", ...){
  #' @export
  slist = sed_rate_l.multiadm(x,h,mode,...)
  cond_list = lapply(slist, function(x) 1/x)
  return(cond_list)
}

condensation_fun = function(x, mode = "rcll", ...){
  #' @export
  #' 
  #' @title condensation function
  #' 
  #' @description
    #' returns a function that determines instantaneous condensation (time preserved per strat. increment)
    #' 
  #' @param x adm object
  #' @param mode string, handed over to _sed_rate_t_, see ?sed_rate_t for details
  #' @param ... parameters passed to _get_time_, see ?get_time for details
  #' 
  #' @returns a function
  
  f = function(h) condensation.adm(x,h,mode,...)
  return(f)
}