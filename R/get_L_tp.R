get_L_tp = function(x, ...){
  #' @export
  #' 
  #' @title get height/length tie point
  #' 
  #' @param x age-depth model (adm) or sediment accumulation curve (sac)
  #' @param ... other options, currently not used
  #' 
  #' @description
    #' extracts the height/length time points from an age-depth model or sediment accumulation curve
    #' 
  #' @returns numeric vector of the time/length tie points
  #' 
  #' @seealso [get_T_tp()] to extract time tie points
  #' 
  UseMethod("get_L_tp")
}

get_L_tp.adm = function(x, ...){
  #' @export
  #' 
  return(x$h)
}

get_L_tp.sac = function(x, ...){
  #' @export
  #' 
  return(x$h)
}