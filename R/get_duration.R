get_duration = function(adm){
  duration = diff(range(adm$t))
  
  return(duration)
}
