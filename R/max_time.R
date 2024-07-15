max_time = function(x){
  #' @export
  #' 
  #' @title extract earliest time from adm
  #' 
  #' @param x age-depth model
  #' 
  #' @returns a scalar, timing of earliest tie point in the adm
  #' 
  #' @seealso [min_time()], [get_total_duration()]
  #' 
  UseMethod("max_time")
}

max_time.adm = function(x){
  #' @export
  #' 
  return(max(x$t))
}