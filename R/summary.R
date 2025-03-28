summary.adm = function(object, ...){
  
  #' @export
  #' 
  #' @title summary of age-depth model
  #' 
  #' @description
  #' Displays some summary numbers of an age-depth models
  #' 
  #' 
  #' @param object an adm object
  #' @param ... other variables, are ignored
  #' 
  #' @returns Invisible NULL, prints summary to the console
  #' 
  #' @examples
  #' my_adm = tp_to_adm(t = 1:5, h = c(2,2,3), L_unit = "m", T_unit = "Myr" )
  #' summary(my_adm)
  #' 
  #' 
  
  adm = object
  cat("age-depth model \n")
  cat("Total duration: ", get_total_duration(adm), " ", adm$T_unit, "\n", sep = "")
  cat("Total thickness: ", get_total_thickness(adm), " ", adm$L_unit , "\n", sep = "")
  cat("Stratigraphic completeness: ", get_completeness(adm) *100 , " % \n", sep = "")
  cat( get_hiat_no(adm), "hiatus(es)")
  return(invisible())
}

summary.multiadm = function(object, ...){
  
  #' @export
  #' 
  #' @title summary of age-depth model
  #' 
  #' @description
  #' Displays some summary numbers of an age-depth models
  #' 
  #' 
  #' @param object a multiadm object
  #' @param ... other variables, are ignored
  #' 
  #' @returns Invisible NULL, prints summary to the console
  #' 
  #' 
  #' 
  
  adm = object
  cat("multiple age-depth models \n")
  cat("Median total duration: ", stats::median(get_total_duration(adm)), " ", adm$T_unit, "\n", sep = "")
  cat("Median total thickness: ", stats::median(get_total_thickness(adm)), " ", adm$L_unit , "\n", sep = "")
  cat("Median stratigraphic completeness: ", stats::median(get_completeness(adm) *100) , " % \n", sep = "")
  cat( stats::median(get_hiat_no(adm)), "hiatus(es) (median)")
  return(invisible())
}

summary.sac = function(object, ...){
  
  #' @export
  #' 
  #' @title summary of sediment accumulation curve
  #' 
  #' @description
    #' displays some summary numbers of sediment accumulation curve
    #' 
  #' @param object sediment accumulation curve (sac)
  #' @param ... other variables, are ignored
  #' 
  #' @returns invisible NULL
  cat("sediment accumulation curve\n")
  cat("Total duration: ", get_total_duration.sac(object), " ", get_T_unit.sac(object), "\n", sep = "")
  cat("Maximum thickness: ", get_total_thickness.sac(object), " ", get_L_unit.sac(object), "\n", sep = "")
  
  return(invisible())
}

summary.ddc = function(object, ...){
  #' @export
  #' 
  #' @title summary of depth-depth curve
  #' 
  #' @description
    #' displays some summary numbers of a depth-depth curve (`ddc` object)
    #' 
  #' @param object depth-depth curve (`ddc`)
  #' @param ... other variables, currently ignored
  #' 
  #' @returns invisible NULL
  #' 
  cat("depth-depth curve\n")
  
  return(invisible())
}