strat_to_time.taxonomy = function(obj, x, ...){
  #' @export
  #' 
  #' @title transform taxonomy object from strat to time domain
  #' 
  #' @param obj `taxonomy` object as defined by the `FossilSim` package
  #' @param x age-depth model
  #' @param ... further parameters passed to _get_time_
  #' 
  obj$start = get_time.adm(x, obj$start, ...)
  obj$end  = get_time.adm(x, obj$start, ...)
  
  return(obj)
}