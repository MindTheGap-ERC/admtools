get_completeness.multiadm = function(x){

  #'
  #' @export
  #'
  
  
  
  adm_list = split_multiadm(x)
  
  completenesses = sapply(seq_along(adm_list), function(x) get_completeness(adm_list[[x]]))
  return(completenesses)
}
