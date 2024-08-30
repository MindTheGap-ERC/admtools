min_time = function(x){
  #' @export
  #' 
  #' @title first time tie point
  #' 
  #' @param x age-depth model (adm) or sediment accumulation curve (sac)
  #' 
  #' @returns number, timing of first tie point of the age-depth model/sediment accumulation curve
  #' 
  #' @seealso [max_time()], [get_total_duration()]
  #' 
  UseMethod("min_time")
}

min_time.adm = function(x){
  #' @export
  #' 
  t = get_T_tp.adm(x)
  return(min(t))
}

min_time.sac = function(x){
  #' @export
  #' 
  t = get_T_tp.sac(x)
  return(min(t))
}