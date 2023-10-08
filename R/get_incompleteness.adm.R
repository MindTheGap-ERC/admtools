get_incompleteness.adm = function(x){
  
  #'
  #' @export
  #' 

  adm = x 
  missing_time = sum(diff(adm$t)[adm$destr])
  total_time = diff(range(adm$t))
  incompl =  missing_time / total_time
  return(incompl)
}