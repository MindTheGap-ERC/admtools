time_to_strat = function(obj, x, ...){
  
  #'
  #' @export
  #' 
  #' @title transform objects from time domain to strat. domain
  #' 
  #' @description
    #' Takes an object and transforms it from the time domain into the stratigraphic domain using the provided age-depth model.
    #' Currently implemented for the "phylo" class.
    #' 
  #' 
  #' @param obj the object to be transformed
  #' @param x age-depth model for the transformation
  #' @param ... other parameters
  #' 
  #' @returns an object of the same type as obj
  #' 
  
  UseMethod("time_to_strat")
  
}