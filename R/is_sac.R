is_sac = function(x){
  #' @export
  #' 
  #' @title is valid sac objects
  #' 
  #' @description
    #' checks if the object is a valid sac object
    #' 
  #' @param x the object to check
  #' 
  #' @returns logical. Is x a valid `sac` object?
  
  if ( ! inherits(x, "sac")) { return(FALSE) }
       
  if (! all(names(x) %in% c("t","h","T_unit","L_unit"))) { return(FALSE) }
  
  if (length(x$t) != length(x$h)) { return(FALSE) }
  
  if (length(x$t) < 2 ) { return(FALSE) }
  
  if ( !(is.null(x$T_unit) | is.character(x$T_unit))) { return(FALSE) }
  if ( !(is.null(x$L_unit) | is.character(x$L_unit))) { return(FALSE) }
  
  if (is.unsorted(x$t, strictly = TRUE)) {return(FALSE)}
  
  return(TRUE)
  
}