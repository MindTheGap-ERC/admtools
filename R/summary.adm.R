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
  #' @return Prints summary to the console and returns an invisible NULL
  #' 
  #' @examples
    #' my_adm = tp_2_adm(t = 1:5, h = c(2,2,3), L_unit = "m", T_unit = "Myr" )
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
