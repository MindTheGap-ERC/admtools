get_hiat_no.multiadm = function(x){
  
  #'
  #' @export
  #' 
  
  multiadm = x
  
  adm_list = split_multiadm(multiadm)
  
  outlist = lapply(amd_list, function(x) get_hiat_no(x))
}