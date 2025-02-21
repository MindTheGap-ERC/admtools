time_to_strat.fossils = function(obj, x, ...){
  
  #' @export
  #' 
  #' @title transform `fossils` from FossilSim from time to strat domain
  #' 
  #' @param obj the fossils object
  #' @param x the age-depth model to be used, and _adm_ object
  #' @param ... further parameters to be passed to `to_height`, e.g., `is_destructive`
  #' 
  #' @returns a `fossils` object for usage with the `FossilSim` package
  #' 
  #' @description
    #' The `fossils` object of the `FossilSim` package describe the location of fossil occurrences along a phylogeny. This function transforms the objects from the time to the stratigraphic domain.
  
  obj$hmin = get_height.adm(x, obj$hmin, ...)
  obj$hmax = get_height.adm(x, obj$hmax, ...)
  destr = is.na(obj$hmin) | is.na(obj$hmax)
  obj = obj[!destr, ]
  return(obj)
}