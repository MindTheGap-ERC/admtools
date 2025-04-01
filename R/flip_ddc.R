flip_ddc = function(x, ...){
  #' @export
  #' 
  #' @title reverse direction of depth-depth curve
  #' 
  #' @param x a depth-depth curve (ddc object)
  #' @param ... other parameters, currently unused
  #' 
  #' @description
    #' reverses the direction of correlation of the depth-depth curve
    #' i.e., if the original depth-depth curve maps section 1 to section 2
    #' the flipped curve maps section 2 to section 1
    #' 
  #' 
  UseMethod("flip_ddc")
}

flip_ddc.default = function(x, ...){
  #' @export
  .NotYetImplemented()
}

flip_ddc.ddc = function(x, ...){
  #' @export
  h1 = x$h1
  L_unit_1 = x$L_unit_1
  sec_1_name = x$sec_1_name
  x$h1 = x$h2
  x$h2 = h1
  x$L_unit_1 = x$L_unit_2
  x$L_unit_2 = L_unit_1
  x$sec_1_name = x$sec_2_name
  x$sec_2_name = sec_1_name
  return(x)
}
