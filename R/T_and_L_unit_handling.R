get_L_unit = function(x, ...){
  
  #'
  #' @export
  #' 
  #' @title extract length unit
  #' 
  #' @description
  #' extracts the length unit from sac, adm or multiadm object
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

get_L_unit.sac = function(x, ...){
  
  #' @export
  
  return(x$L_unit)
}

get_L_unit.ddm = function(x, ...){
  
  #' @export
  stop("No single L unit defined for depth-depth curves. Use `get_L_units` instead.")
}

get_L_unit.default = function(x, ...){
  
  .NotYetImplemented()
}


set_L_unit = function(x, L_unit, ...){
  
  #' 
  #' @export
  #' 
  #' @title set length units
  #' 
  #' @description
  #' set length units for sac, adm and multiadm objects
  #' 
  #'
  #' @param x adm or multiadm object
  #' @param L_unit length unit
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

set_L_unit.sac = function(x, L_unit, ...){
  
  #' @export
  #' 
  x$L_unit = L_unit
  return(x)
}

set_L_unit.ddc = function(x, L_unit, ...){
  #' @export
  stop("Can not set individual L unit for depth-depth curves. Use `set_L_units` instead.")
}


set_L_unit.default = function(x, L_unit, ...){
  #' @export
  .NotYetImplemented()
}


get_T_unit = function(x, ...){
  
  #'
  #' @export
  #' 
  #' @title extract Time unit
  #' 
  #' @description
  #' extracts the Time unit from sac, adm or multiadm object
  #'
  #' @param x sac, adm or multiadm object
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

get_T_unit.sac = function(x, ...){
  
  #' @export
  
  return(x$T_unit)
}

get_T_unit.ddc = function(x, ...){
  #' @export
  stop("No time unit associated with depth-depth curve")
}

get_T_unit.default = function(x, ...){
  #' @export
  .NotYetImplemented()
}


set_T_unit = function(x, T_unit, ...){
  
  #' 
  #' @export
  #' 
  #' @title set time units
  #' 
  #' @description
  #' set time units for sac, adm and multiadm objects
  #' 
  #'
  #' @param x sac, adm or multiadm object
  #' @param T_unit time unit
  #' @param ... further parameters
  #' 
  #' @returns an sac, adm or multiadm object with the time unit assigned
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

set_T_unit.sac = function(x, T_unit, ...){
  
  #' @export
  #' 
  x$T_unit = T_unit
  return(x)
}

set_T_unit.ddc = function(x, T_unit, ...){
  #' @export
  stop("No T unit associated with depth-depth curves\n")
}

set_T_unit.default = function(x, T_unit, ...){
  #' @export
  .NotYetImplemented()
}


get_L_units = function(x, ...){
  
  #'
  #' @export
  #' 
  #' @title extract length units
  #' 
  #' @description
  #' extracts the length unit from depth-depth curves (ddc objects)
  #'
  #' @param x an ddc object
  #' @param ... other parameters
  #' 
  #' @returns character - the length unit of `x`
  #' 
  #' @seealso [get_L_unit()] [set_L_unit()] to extract length units from age-depth models or sediment accumulation curves
  # 
  
  UseMethod("get_L_units")
}


get_L_units.default = function(x, ...){
  #' @export
  .NotYetImplemented()
}

get_L_units.ddc = function(x, ...){
  #' @export
  names = c("sec_1" = x$L_unit_1, "sec_2" = x$L_unit_2)
  return(names)
}


set_L_units = function(x, L_units, ...){
  
  #' 
  #' @export
  #' 
  #' @title set length units
  #' 
  #' @description
  #' set length units for depth-depth curves
  #' 
  #'
  #' @param x depth-depth curve (ddc object)
  #' @param L_units length units, vector of length 2. i-th element is the length unit of i-th section
  #' @param ... further parameters
  #' 
  #' @returns an ddc object with the L unit assigned
  #' 
  #' @seealso [set_L_unit()] [get_L_units()]
  #' 
  
  UseMethod("set_L_unit")
}

set_L_units.default = function(x, L_units, ...){
  #' 
  #' @export
  
  .NotYetImplemented()
}

set_L_units.ddc = function(x, L_units, ...){
  #' @export
  
  x$L_unit_1 = L_units[1]
  x$L_unit_2 = L_units[2]
  return(x)
}
