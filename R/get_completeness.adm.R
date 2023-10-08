get_completeness.adm = function(x){
  

  #' 
  #' @export
  #' 
  
  adm = x 
  missing_time = sum(diff(adm$t)[adm$destr])
  total_time = diff(range(adm$t))
  compl = 1-  missing_time / total_time
  return(compl)
}
