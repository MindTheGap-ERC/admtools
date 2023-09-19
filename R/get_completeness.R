get_completeness = function(adm){
  missing_time = sum(diff(adm$t)[adm$destr])
  total_time = get_duration(adm)
  compl = 1-  missing_time / total_time
  return(compl)
}
