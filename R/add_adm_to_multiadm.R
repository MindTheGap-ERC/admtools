add_adm_to_multiadm = function(x, ...){
  
  #'
  #' @export
  #' 
  #' @title add adm object ot multiadm object
  #' 
  #' @param x multiadm object
  #' @param ... adm objects to be added to x
  #' 
  #' @returns a multiadm object
  #' 
  
  inlist = list(...)
  
  
  for (i in seq_along(inlist)){
    x[["t"]][[x$no_of_entries + i]] = inlist[[i]]$t
    x[["h"]][[x$no_of_entries + i]] = inlist[[i]]$h
    x[["destr"]][[x$no_of_entries + i]] = inlist[[i]]$destr
    if (x$T_unit != get_T_unit(inlist[[i]])){
      stop("Inconsistent time units, can not merge")
    }
    if (x$L_unit != get_L_unit(inlist[[i]])){
      stop("Inconsistent length units, can not merge")
    }
    
  }
  x$no_of_entries = x$no_of_entries + length(inlist)
  
  return(x)
}