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
  stopifnot(class(adm) == "adm")
  stopifnot(length(adm$t) == length(adm$h))
  stopifnot(all(diff(adm$t) > 0 ))
  stopifnot(all(diff(adm$h) >= 0))
  stopifnot(length(adm$destr) == length(adm$t) + 1)
  return(TRUE)
}