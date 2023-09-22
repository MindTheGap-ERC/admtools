get_total_thickness.adm = function(adm){
  return(diff(range(adm$h)))
}
