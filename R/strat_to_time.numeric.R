strat_to_time.numeric = function(obj, x, ...){
  
  #' 
  #' @export
  #' 
  #' @title transform numeric vectors from height to time domain
  #' 
  #' @description
  #' This function transforms numeric vectors from the stratigrahpic to the time domain
  #' Fundamentally a wrapper around get_time for consistent syntax
  #' 
  #' 
  #' @param obj a numeric vector representing stratigraphic positions.
  #' @param x an _adm_ object
  #' @param ... options passed to `get_time`
  #' 
  #' @seealso [time_to_strat.numeric()] for the transformation from time to height domain, [get_time()] for the underlying procedure, [time_to_strat()] for the higher level function, [strat_to_time.list()] and [strat_to_time.phylo()] for the transformation of lists and phylogenetic trees.
  #' 
  #' @returns A numeric vector with times of deposition of the entries in `obj`
  #' 
  #' @examples
  #' # see vignette("admtools") for an example
  #' 
  
  t = get_time(x, obj, ...)

  return(t)
}