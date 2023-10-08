get_total_thickness.adm = function(x){
  
  #' 
  #' @export
  #' 
  #' 

  adm = x
  return(diff(range(adm$h)))
}
