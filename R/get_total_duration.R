get_total_duration = function(x, ...){
  
  #' @export
  #' 
  #' @title Total duration covered 
  #' 
  #' @param x age-depth model (adm/multiadm) or sediment accumulation curve (sac)
  #' @param ... other options, currently unused
  #' 
  #' @returns numeric, total duration covered by the age-depth models/sediment accumulation curve
  #' 
  #' @seealso [min_time()] and [max_time()] to extract the first/last tie point in time
  #' 
  UseMethod("get_total_duration")
}

get_total_duration.adm = function(x, ...){
  
  #'
  #' @export
  #' 
  adm = x
  return(diff(range(adm$t)))
}

get_total_duration.multiadm = function(x, ...){
  #'
  #' @export
  #' 
  
  multiadm = x
  
  adm_list = split_multiadm(multiadm)
  
  durations  = sapply(adm_list, function(x) get_total_duration(x))
  return(durations)
  
}

get_total_duration.sac = function(x, ...){
  #' @export
  #' 
  t = get_T_tp(x)
  return(diff(range(t)))
}
