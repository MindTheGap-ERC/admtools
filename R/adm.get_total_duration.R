adm.get_total_duration = function(adm){
  return(diff(range(adm$t)))
}
