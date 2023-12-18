get_height.multiadm = function(x, t, destructive = TRUE, out_dom_val_h = "default", ...){
  
  #'
  #' @export
  #' 
  
  adm_list = split_multiadm(x)
  
  h_list = lapply(adm_list, function(x) get_height(x, t, destructive, out_dom_val_h, ...))
  
  return(h_list)
  
}