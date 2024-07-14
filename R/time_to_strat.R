time_to_strat = function(obj, x, ...){
  
  #'
  #' @export
  #' 
  #' @title transform objects from time domain to strat. domain
  #' 
  #' @description
    #' Takes an object and transforms it from the time domain into the stratigraphic domain using the provided age-depth model.
    #' Currently implemented for the "phylo", "list", and "numeric" class.
    #' 
  #' 
  #' @param obj the object to be transformed
  #' @param x age-depth model for the transformation
  #' @param ... other parameters
  #' 
  #' @returns an object of the same type as obj
  #' 
  #' @seealso [strat_to_time()] to transform data from the stratigraphic domain to the time domain, [time_to_strat.phylo()], [time_to_strat.numeric()] and [time_to_strat.list()] for details on how to transfrom phylo objects, vectors, and lists. See [get_height()] for the underlying procedure.
  #' 
  
  UseMethod("time_to_strat")
  
}