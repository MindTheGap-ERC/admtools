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
  #' @return Prints summary to the console and returns an invisible NULL
  #' 
  #' 
  #' 
  
  adm = object
  cat("multiple age-depth models \n")
  cat("Median total duration: ", median(get_total_duration(adm)), " ", adm$T_unit, "\n", sep = "")
  cat("Median total thickness: ", median(get_total_thickness(adm)), " ", adm$L_unit , "\n", sep = "")
  cat("Median stratigraphic completeness: ", median(get_completeness(adm) *100) , " % \n", sep = "")
  cat( median(get_hiat_no(adm)), "hiatus(es) (median)")
  return(invisible())
}