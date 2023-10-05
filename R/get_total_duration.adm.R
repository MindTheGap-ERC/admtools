get_total_duration.adm = function(adm){
  
  #' @export
  #' 
  return(diff(range(adm$t)))
}
