get_incompleteness.multiadm = function(x){
  
  #'
  #' @export
  #' 
  
  adm_list = split_multiadm(x)
  
  out = sapply(adm_list, function(x) get_incompleteness(x))
  
  return(out)
}