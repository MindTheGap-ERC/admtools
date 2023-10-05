get_total_thickness.adm = function(adm){
  
  #' 
  #' @export
  #' 
  #' 
  return(diff(range(adm$h)))
}
