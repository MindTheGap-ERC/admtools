get_completeness.multiadm = function(multiadm){
  
  adm_list = split_multiadm(multiadm)
  
  completenesses = sapply(seq_along(adm_list), function(x) get_completeness(adm_list[[x]]))
}
