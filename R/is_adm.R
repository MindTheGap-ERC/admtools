is_adm = function(x, quietly = TRUE){
  
  #'
  #' @export
  #'
  #' @title Is an adm object a valid age-depth model
  #' 
  #' @description
    #' Constructors for adm objects such as _tp_to_adm_ do not check whether the inputs define a valid
    #' age-depth mode, e.g. one where the law of superposition holds. This function performs these checks 
    #' 
  #' 
  #' @param x an object
  #' @param quietly logical. should descriptive warnings be shown?
  #' 
  #' @returns logical. Is the input a valid adm object?
  #' 
  #' 
  #' @examples
    #' 
    #' x = tp_to_adm(t = c(2,1), h = c(1,2)) # reversed order of time tie points
    #' is_adm(x) # returns FALSE
    #' 
    #' 

  
  warning_status = getOption("warn")
  if (quietly){
    options("warn" = -1)
  }
  
  if ( ! inherits(x, "adm") ){
    warning("Expected adm class")
    options("warn" = warning_status)
    return(FALSE)
  }
  
  has_valid_names = all( names(x) %in% c("t","h","destr", "T_unit", "L_unit"))
  if (! has_valid_names){
    warning("Invalid names")
    options("warn" = warning_status)
    return(FALSE)
  }
  
  if (length(names(x)) != 5){
    warning("Missing name fields")
    options("warn" = warning_status)
    return(FALSE)
  }
  
if(length(x$t) != length(x$h)){
  warning("Number of tie points in time and height differs")
  options("warn" = warning_status)
  return(FALSE)
}
  
if(length(x$t) != (length(x$destr)+1)){
  warning("Number of tie points does not match information on destructive intervals")
  options("warn" = warning_status)
  return(FALSE)
}

if ( !all(diff(x$t) > 0 ) ){
  warning("Time tie points must be strictly increasing")
  options("warn" = warning_status)
  return(FALSE)
}

if (!all(diff(x$h) >= 0)){
  warning("Law of superposition is not met")
  options("warn" = warning_status)
  return(FALSE)
}
  
  options("warn" = warning_status)

  return(TRUE)
}
