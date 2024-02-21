sed_rate_l = function(x,h, mode = "rcll",...){
  #' @export
  #' 
  #' @title sedimentation rate in stratigraphic height
  #' 
  #' @description
    #' determines instantaneous sedimentation rate at a specified stratigraphic position
    #' 
  #' @param x adm object
  #' @param h numeric vector, stratigraphic positions
  #' @param mode string, handed over to _sed_rate_t_, see ?sed_rate_t for details
  #' @param ... parameters passed to _get_time_, see ?get_time for details
  #' 
  #' @returns a vector of sed rates (if x is an adm object), or a list of sedimentation rates
  #' 
  UseMethod("sed_rate_l")
}

sed_rate_l.adm = function(x,h, mode = "rcll",...){
  #' @export
  t = get_time.adm(x,h, ...)
  srate = sed_rate_t.adm(x,t,mode)
  return(srate)  
}

sed_rate_l.multiadm = function(x,h, mode = "rcll",...){
  #' @export
  adm_list = split_multiadm(x)
  
  h_list = lapply(adm_list, function(x) sed_rate_l.adm(x,h, mode = "rcll",...))
  
  return(h_list)
}

sed_rate_l_fun = function(x, mode = "rcll",...){
  #' @export
  #' 
  #' @title sed rate in height function
  #' 
  #' @description
    #' returns a function that determines sed. rates in height
    #' 
  #' @param x an adm object
  #' @param mode string, handed over to _sed_rate_t_, see ?sed_rate_t for details
  #' @param ... parameters passed to _get_time_, see ?get_time for details
  #' 
  #' @returns a function
  #' 
  f = function(h) sed_rate_l.adm(x,h,mode,...)
  return(f)
  
}