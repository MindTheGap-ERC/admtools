get_hiat_pos.multiadm = function(x){
  
  #'
  #' @export
  #' 
  
  multiadm = x
  
  adm_list = split_multiadm(multiadm)
  
  outlist = lapply(adm_list, function(x) get_hiat_pos(x))
  
  return(outlist)
}