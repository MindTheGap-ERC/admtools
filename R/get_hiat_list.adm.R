get_hiat_list.adm = function(x){
  
  #' @export
  hiat_pos = get_hiat_pos(x)
  no_of_hiat = get_hiat_no()
  hiat_list = list()
  adm = x
  for (i in seq_len(no_of_hiat)){
    hiat_list[[i]][["height"]] = hiat_pos[i]
    hiat_list[[i]][["start"]] = min(adm$t[adm$h == hiat_pos[i]])
    hiat_list[[i]][["end"]] = max(adm$t[adm$h == hiat_pos[i]])
  }
  
  return(hiat_list)
  
}