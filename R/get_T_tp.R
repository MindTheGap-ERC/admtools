get_T_tp = function(x, ...){
  #' @export
  #' 
  #' @title extract time tie points
  #' 
  #' @param x age-depth model (adm) or sediment accumulation curve (sac)
  #' @param ... other options, currently unused
  #' 
  #' @description
    #' Extracts the time tie points from an age-depth model or sediment accumulation curve
    #' 
  #' @returns a vector, containing the time tie points
  #' 
  #' @seealso [get_L_tp()] to extract length/height tie points
  #' 
  UseMethod("get_T_tp")
}

get_T_tp.adm = function(x, ...){
  #' @export
  return(x$t)
}

get_T_tp.sac = function(x, ...){
  #' @export
  return(x$t)
}