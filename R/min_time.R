min_time = function(x){
  #' @export
  #' 
  #' @title extract last time from adm
  #' 
  #' @param x age-depth model
  #' 
  #' @returns a scalar, timing of last tie point in the adm
  #' 
  #' @seealso [max_time()], [get_total_duration()]
  #' 
  UseMethod("min_time")
}

min_time.adm = function(x){
  #' @export
  #' 
  return(min(x$t))
}