get_time.multiadm = function(x, h, hiat_mode = "start", bdry_pts_hiat = "destructive", out_dom_val_t = "default"){
  
  #'
  #' @export
  #'
  
  adm_list = split_multiadm(x)
  
  t_list = lapply(adm_list, function(x) get_time(x, h, hiat_mode, bdry_pts_hiat, out_dom_val_t))
  
  return(t_list)
}