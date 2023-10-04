get_completeness.adm = function(adm){
  
  #'
  #' @title Determine stratigraphic completeness
  #' 
  #' @param adm an adm object
  #' 
  #' @return Number between 0 and 1, the stratigraphic completeness
  #' 
  #' @export
  missing_time = sum(diff(adm$t)[adm$destr])
  total_time = diff(range(adm$t))
  compl = 1-  missing_time / total_time
  return(compl)
}
