get_total_thicknesses = function(x, ...){
  #' @export
  #' 
  #' @title get thicknesses of sections from depth-depth curves
  #' 
  #' @param x a depth-depth curve (ddc object)
  #' @param ... other parameters (currently unused)
  #' 
  #' @returns a numeric vector of length 2 - the thicknesses of section 1 and 2 in the depth-depth curve
  #' 
  #' @seealso 
    #' *  [get_total_thickness()] to determine the total thickness accumulated by age-depth models or sediment accumulation curves.
  
  UseMethod("get_total_thicknesses")
}

get_total_thicknesses.default = function(x, ...){
  #' @export
  .NotYetImplemented()
}

get_total_thicknesses.ddc = function(x, ...){
  #' @export
  #' 
  return(c("sec_1" = diff(range(x$h1)), "sec_2" = diff(range(x$h2))))
}