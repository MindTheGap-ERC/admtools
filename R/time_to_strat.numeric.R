time_to_strat.numeric = function(obj, x, ...){
  #' 
  #' @export
  #' 
  #' @title transform vectors from time to height domain
  #' 
  #' @description
  #' This function transforms numeric vectors from the time to the stratigraphic domain
  #' Fundamentally a wrapper around get_height for consistent syntax
  #' 
  #' 
  #' @param obj a numeric vector, interpreted as timing of events
  #' @param x an _adm_ object
  #' @param ... options passed to _get_height_
  #' 
  #' @seealso [strat_to_time.numeric()] for the transformation from height to time domain, [time_to_strat.phylo()] and [time_to_strat.list()] for transformations of phylogenetic trees and lists. See [get_height()] for the underlying procedure.
  #' 
  #' @returns a numeric vector - stratigraphic position of the events
  #' 
  #' @examples
  #' # see vignette("admtools") for an example
  #' 
  
  
  h  = get_height(x, t = obj, ...)
  return(h)
  
}