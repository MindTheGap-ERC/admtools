get_L_unit = function(x, ...){
  
  #'
  #' @export
  #' 
  #' @title extract length unit
  #' 
  #' @description
  #' extracts the length unit from adm or multiadm object
  #'
  #' @param x adm or multiadm object
  #' @param ... other parameters
  #' 
  #' @returns character - the length unit of `x`
  #' 
  #' @seealso [get_T_unit()] [set_L_unit()]
  # 
  
  UseMethod("get_L_unit")
}

get_L_unit.adm = function(x, ...){
  
  #' @export
  
  return(x$L_unit)
}

get_L_unit.multiadm = function(x, ...){
  
  #' @export
  
  return(x$L_unit)
}

set_L_unit = function(x, L_unit, ...){
  
  #' 
  #' @export
  #' 
  #' @title set length units
  #' 
  #' @description
  #' set length units for adm and multiadm objects
  #' 
  #'
  #' @param x adm or multiadm object
  #' @param L_unit time unit
  #' @param ... further parameters
  #' 
  #' @returns an adm or multiadm object with the L unit assigned
  #' 
  #' @seealso [set_T_unit()] [get_L_unit()]
  #' 
  
  UseMethod("set_L_unit")
}

set_L_unit.adm = function(x, L_unit, ...){
  
  #' @export
  
  x$L_unit = L_unit
  return(x)
}

set_L_unit.multiadm = function(x, L_unit, ...){
  
  #' @export
  #' 
  x$L_unit = L_unit
  return(x)
}

get_T_unit = function(x, ...){
  
  #'
  #' @export
  #' 
  #' @title extract Time unit
  #' 
  #' @description
  #' extracts the Time unit from adm or multiadm object
  #'
  #' @param x adm or multiadm object
  #' @param ... other parameters
  #' 
  #' @returns character - the time unit of `x`
  #'
  #' @seealso [set_T_unit()] [get_L_unit()]
  
  UseMethod("get_T_unit")
}

get_T_unit.adm = function(x, ...){
  
  #' @export
  
  return(x$T_unit)
}

get_T_unit.multiadm = function(x, ...){
  
  #' @export
  
  return(x$T_unit)
}

set_T_unit = function(x, T_unit, ...){
  
  #' 
  #' @export
  #' 
  #' @title set time units
  #' 
  #' @description
  #' set time units for adm and multiadm objects
  #' 
  #'
  #' @param x adm or multiadm object
  #' @param T_unit time unit
  #' @param ... further parameters
  #' 
  #' @returns an adm or multiadm object with the time unit assigned
  #' 
  #' @seealso [set_L_unit()] [get_T_unit()]
  #' 
  
  UseMethod("set_T_unit")
}

set_T_unit.adm = function(x, T_unit, ...){
  
  #' @export
  
  x$T_unit = T_unit
  return(x)
}

set_T_unit.multiadm = function(x, T_unit, ...){
  
  #' @export
  #' 
  x$T_unit = T_unit
  return(x)
}