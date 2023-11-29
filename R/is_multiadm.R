is_multiadm = function(x){
  
  #'
  #' @title is valid multiadm object?
  #' 
  #' @param x object to be tested
  #' 
  #' @returns Boolean. Is the object a valid multiadm object?
  #' 
  
  if ( ! inherits(x, "multiadm") ){
    warning("Expected multiadm class")
    return(FALSE)
  }
  
  
  has_valid_names = all( names(x) %in% c("t","h","destr","no_of_entries", "T_unit", "L_unit"))
  if (! has_valid_names){
    warning("Invalid names")
    return(FALSE)
  }
  
  if (length(names(x)) != 6){
    warning("Missing name fields")
    return(FALSE)
  }
  
  return(TRUE)
  
}