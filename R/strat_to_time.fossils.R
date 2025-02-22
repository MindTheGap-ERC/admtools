strat_to_time.fossils = function(obj, x, ...){
  
  #' @export
  #' 
  #' @title transform `fossils` object from `FossilSim` between time and strat domain
  #' 
  #' @param obj the `fossils` object
  #' @param x the age-depth model
  #' @param ... further parameters passed to _get_height`
  #' 
  #' @description
    #' transforms `fossil` objects from stratigraphic to time domain
    #' `
  obj$hmin = get_height.adm(x, obj$hmin, ...)
  obj$hmax = get_height.adm(x, obj$hmax, ...)
  
  destr = is.na(obj$hmin) | is.na(obj$hmax)
  
  obj = obj[!destr, ]
  
  return(obj)
}