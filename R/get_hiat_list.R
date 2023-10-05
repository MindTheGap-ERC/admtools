get_hiat_list = function(adm){
  
  #' 
  #' @title extract hiatus list from adm
  #' 
  #' @param adm an adm object
  #' 
  
  
  hiat_pos = adm$h[duplicated(adm$h)]
  no_of_hiat = length(hiat_pos)
  hiat_list = list()
  for (i in seq_len(no_of_hiat)){
    hiat_list[[i]][["height"]] = hiat_pos[i]
    hiat_list[[i]][["start"]] = min(adm$t[adm$h == hiat_pos[i]])
    hiat_list[[i]][["end"]] = max(adm$t[adm$h == hiat_pos[i]])
  }

  return(hiat_list)
  
  
}