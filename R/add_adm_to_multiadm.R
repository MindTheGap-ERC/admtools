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
    
  }
  x$no_of_entries = x$no_of_entries + length(inlist)
}