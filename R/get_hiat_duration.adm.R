get_hiat_duration.adm = function(x) {
  
  
  #' @export
  hiat_pos = get_hiat_pos(x)
  no_of_hiat = get_hiat_no(x)
  hiat_dur = rep(NA_real_, no_of_hiat)
  adm = x
  for (i in seq_len(no_of_hiat)){
    hiat_dur[i] = diff(range(adm$t[adm$h == hiat_pos[i]]))
  }
  
  return(hiat_dur)
  
}