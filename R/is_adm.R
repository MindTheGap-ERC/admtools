is_adm = function(adm){
  #'
  #'
  #' @title Is an adm object a valid age-depth model
  #' 
  #' @description
    #' Contructors for adm objects such as _tp_2_adm_ do not check whether the inputs define a valid
    #' age-depth mode, e.g. one where the law of superposition holds. This function performs these checks 
    #' 
  #' 
  #' @param adm an object
  #' 
  #' @returns logical. Is the input a valid adm object?
  #' 
  #' 
  #' 
  
  if ( ! inherits(adm, "adm") ){
    warning("Expected adm class")
    return(FALSE)
  }
  
if(length(adm$t) != length(adm$h)){
  warning("Number of tie points in time and height differs")
  return(FALSE)
}
if (!all(diff(adm$t) > 0 )){
  warning("Time tie points must be strictly increasing")
  return(FALSE)
}

if (!all(diff(adm$h) >= 0)){
  warning("Law of superposition is not met")
  return(FALSE)
}

  return(TRUE)
}