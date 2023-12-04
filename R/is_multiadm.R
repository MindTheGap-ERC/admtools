is_multiadm = function(x, quietly = TRUE){
  
  #'
  #' @title is valid multiadm object?
  #' 
  #' @param x object to be tested
  #' @param quietly logical, should a descriptive warning be returned?
  #' 
  #' @returns Logical. Is the object a valid multiadm object?
  #' 
  
  
  warning_status = getOption("warn")
  if (quietly){
    options("warn" = -1)
  }
  
  if ( ! inherits(x, "multiadm") ){
    warning("Expected multiadm class")
    options("warn" = warning_status)
    return(FALSE)
  }
  
  
  has_valid_names = all( names(x) %in% c("t","h","destr","no_of_entries", "T_unit", "L_unit"))
  if (! has_valid_names){
    warning("Invalid names")
    options("warn" = warning_status)
    return(FALSE)
  }
  
  if (length(names(x)) != 6){
    warning("Missing name fields")
    options("warn" = warning_status)
    return(FALSE)
  }
  
  options("warn" = warning_status)
  return(TRUE)
  
}