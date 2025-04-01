time_to_strat.taxonomy = function(obj, x, ...){
  #' @export
  #' 
  #' @title transform `taxomony` from time to strat domain
  #' 
  #' @param obj a `taxonomy` object used by `FossilSim`
  #' @param x an age-depth model object
  #' @param ... further parameters passed to `get_height`, e.g., _is_destructive_
  #' 
  #' @description
    #' transforms `taxonomy` objects from time to strat domain. Ignored the `destructive` argument of _get_height_, which is automatically set to FALSE
    #' 
  
  obj$start = get_height.adm( x,obj$start, destructive = FALSE)
  obj$end = get_height.adm( x, obj$end, destructive = FALSE)
  
  return(obj)
}