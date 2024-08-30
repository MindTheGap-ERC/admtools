max_time = function(x){
  #' @export
  #' 
  #' @title last time tie point
  #' 
  #' @param x age-depth model (adm) or sediment accumulation curve (sac)
  #' 
  #' @returns number, last time tie point of the age-depth model/sediment accumulation curve
  #' 
  #' @seealso [min_time()], [get_total_duration()]
  #' 
  UseMethod("max_time")
}

max_time.adm = function(x){
  #' @export
  #' 
  t = get_T_tp.adm(x)
  return(max(t))
}

max_time.sac = function(x){
  #' @export
  t = get_T_tp.sac(x)
  return(max(t))
}