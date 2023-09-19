is_adm = functino(adm){
  #'
  #' @title Checks for validity of adm object
  #' 
  #' @param adm an object
  #' 
  #' @returns logical. Is the input a valid adm object?
  #' 
  stopifnot(class(adm) == "adm")
  stopifnot(length(adm$t) == length(adm$h))
  stopifnot(all(diff(adm$t) > 0 ))
  stopifnot(all(diff(adm$h) >= 0))
  stopifnot(length(adm$destr) == length(adm$t) + 1)
  return(TRUE)
}