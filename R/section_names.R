get_section_names = function(x, ...){
  #' @export
  #' 
  #' @title get section names from depth-depth curve
  #' 
  #' @param x a depth-depth curve (ddc object)
  #' @param ... other parameters (currently unused)
  #' 
  #' @returns vector of length 2, section names of the correlated sections
  UseMethod("get_section_names")
}

get_section_names.ddc = function(x, ...){
  #' @export
  return(c("sec_1" = x$sec_1_name, "sec_2" = x$sec_2_name))
}

get_section_names.default = function(x, ...){
  #' @export
  #' 
  .NotYetImplemented()
}

set_section_names = function(x, sec_names, ...){
  #' @export
  #' 
  #' @title set section names for depth-depth curves
  #' 
  #' @param x a depth-depth curve (ddc object)
  #' @param sec_names vector of length 2, section names assigned to the depth-depth curve
  #' @param ... other parameters (currently unused)
  #' 
  #' @returns a depth-depth curve with assigned section names
  
  UseMethod("set_section_names")
}

set_section_names.default = function(x, sec_names, ...){
  #' @export
  
  .NotYetImplemented()
}

set_section_names.ddc = function(x, sec_names, ...){
  #' @export
  
  x$sec_1_name = sec_names[1]
  x$sec_2_name = sec_names[2]
  return(x)
}