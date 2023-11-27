get_total_thickness.multiadm = function(x){
  
  #'
  #' @export
  #' 
  
  multiadm = x
  
  adm_list = split_multiadm(multiadm)
  
  thicknesses  = sapply(adm_list, function(x) get_total_thickness(x))
  return(thicknesses)
  
  
}
