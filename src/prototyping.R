age_to_time = function(age) {
  time = -age
  return(time)
}

depth_to_height = function(depth){
  height = - depth
  return(height)
}

condensation_in_length_dim_to_sedrate = function(condensation){
  if (any(condensation <= 0)){
    stop("Condensation in spatial domain must be > 0")
  }
  sed_rate = condensation^(-1)
  return(sed_rate)
}

order_with_time_increasing_base = function(time, vals) {
  if (any(duplicated(time))) {
    stop("Error: Duplicated tie points in time dimension")
  }
  if (!is.unsorted(time,strictly = FALSE)) {
    return(list(time = time,
                vals = vals))
  }
  if (is.unsorted(time, strictly = TRUE)) {
    sorted_list=sort(time, 
                     index.return = TRUE)
    time = sorted_list$x
    vals = vals[sorted_list$ix]
    return(list(time = time, 
                vals = vals))
  }
}

time_height_tie_points_to_adm = function(time, 
                                         height, 
                                         lmode = "height", 
                                         tmode = "time", 
                                         interpol_data = NULL, 
                                         derivative_data = NULL) {
  
  temp_list = order_with_time_increasing_base(time = time,
                                         vals = height)
  adm=list(tpoints = temp_list$time, 
           lpoints = temp_list$height, 
           interpol_mode = "piecewise_linear",
           interpol_data = interpol_data, 
           derivative_data = derivative_data, 
           lmode = lmode, 
           tmode = tmode
           )
  return(adm)
}

time_depth_tie_points_to_adm = function(time, 
                                        depth, 
                                        lmode = "depth", 
                                        tmode = "time") {
  height = depth_to_height(depth = depth)
  adm = time_height_tie_points_to_adm(time = time, 
                                      height = height, 
                                      lmode = lmode,
                                      tmode = tmode)
  return(adm)
}

age_height_tie_points_to_adm = function(age, 
                                        depth, 
                                        lmode = "height", 
                                        tmode = "age") {
  time = age_to_time(age = age)
  adm = time_height_tie_points_to_adm(time = time, 
                                      height = height, 
                                      lmode = lmode,
                                      tmode = tmode)
  return(adm)
}

age_depth_tie_points_to_adm = function(age, 
                                       depth, 
                                       lmode = "depth", 
                                       tmode = "age") {
  height = depth_to_height(depth = depth)
  time = age_to_time(age = age)
  adm = time_height_tie_points_to_adm(time = time, 
                                     height = height, 
                                     lmode = lmode,
                                     tmode = tmode)
  return(adm)
}

order_with_time_increasing_mod = function(time, vals) {
  if (any(duplicated(time))) {
    stop("Error: Duplicated tie points in time dimension")
  }
  # for case where length(time) neq length(vals)
  if (!is.unsorted(time, strictly = TRUE)) {
    return(list(time = time,
                vals = vals))
  }
  time = rev(time)
  if (!is.unsorted(time, strictly = TRUE)) {
    return(list(time = time,
                vals = vals))
  }
  stop("Could not sort along time dimension")
  
}