get_total_duration.multiadm = function(x){
  #'
  #' @export
  #' 
  multiadm = x
  
  adm_list = split_multiadm(multiadm)
  
  durations  = sapply(adm_list, function(x) get_total_duration(x))
  return(durations)
  
}
