get_total_duration.adm = function(x){
  
  #'
  #' @export
  #' 
  adm = x
  return(diff(range(adm$t)))
}
