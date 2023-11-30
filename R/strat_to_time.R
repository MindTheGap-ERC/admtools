strat_to_time = function(obj, x, ...){
  
  #'
  #' @export
  #' 
  #' @title transform objects from strat. to time domain
  #' 
  #' @description
    #' Takes an object and transforms it from the time domain into the stratigraphic domain using the provided age-depth model.
    #' Currently implemented for the "phylo" class.
    #' 
  #' 
  #' @param obj the object to be transformed
  #' @param x age-depth model
  #' @param ... other parameters
  #' 
  #' @returns an object of the same type as obj
  #' 
  #' @seealso [time_to_strat()] to transform data from the time to the stratigraphic domain
  #' 
  
  UseMethod("strat_to_time")
  
}