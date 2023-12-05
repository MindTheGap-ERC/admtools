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
    x[["T_unit"]][[x$no_of_entries + i]] = inlist[[i]]$T_unit
    x[["L_unit"]][[x$no_of_entries + i]] = inlist[[i]]$L_unit
    
  }
  x$no_of_entries = x$no_of_entries + length(inlist)
  
  return(x)
}