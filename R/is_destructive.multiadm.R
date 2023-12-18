is_destructive.multiadm = function(x, t, mode = "rcll", bdry_pts_hiat = "destructive", out_dom_mode = "default"){

  #'
  #' @export
  #' 
  
  adm_list = split_multiadm(x)
  
  destr_list = lapply(adm_list, function(x) is_destructive(x, t, mode, bdry_pts_hiat, out_dom_mode))
  
  return(destr_list)
    
}

