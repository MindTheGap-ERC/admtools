age_to_time = function(age) {
  time = -age
  return(time)
}

depth_to_height = function(depth){
  height = - depth
  return(height)
}

order_with_time_increasing = function(time, height) {
  if (any(duplicated(time))) {
    stop("Error: Duplicated tie points in time dimension")
  }
  if (!is.unsorted(time,strictly = FALSE)) {
    return(list(time = time,
                height = height))
  }
  if (is.unsorted(time, strictly = TRUE)) {
    sorted_list=sort(time, 
                     index.return = TRUE)
    time = sorted_list$x
    height = height[sorted_list$ix]
    return(list(time = time, 
                height = height))
  }
  time = rev(time)
  height = rev(height)
  if (is.unsorted(time, strictly = TRUE)) {
    sorted_list=sort(time, 
                     index.return = TRUE)
    time = sorted_list$x
    height = height[sorted_list$ix]
    return(list(time = time, 
                height = height))
  }
  stop("Disordered tie points in time timension")
}

time_height_tie_points_to_adm = function(time, height, lmode = "height", tmode = "time") {
  temp_list = order_with_time_increasing(time = time,
                                         height = height)
  adm=list(tpoints = temp_list$time, 
           lpoints = temp_list$height, 
           interpol_mode = "piecewise_linear",
           interpol_data = NULL, 
           derivative_data = NULL, 
           lmode = lmode, 
           tmode = tmode
           )
  return(adm)
}

age_height_tie_points_to_adm = function(age, depth, lmode = "height", tmode = "age") {
  time = age_to_time(age = age)
  adm = time_height_tie_points_to_adm(time = time, 
                                      height = height, 
                                      lmode = lmode,
                                      tmode = tmode)
}

age_depth_tie_points_to_adm = function(age, depth, lmode = "depth", tmode = "age") {
  height = depth_to_height(depth = depth)
  adm = age_height_tie_points_to_adm(time = time, 
                                      height = height, 
                                      lmode = lmode,
                                      tmode = tmode)
}

time_depth_tie_points_to_adm = function(age, depth, lmode = "depth", tmode = "time") {
  height = depth_to_height(depth = depth)
  adm = time_height_tie_points_to_adm(time = time, 
                                     height = height, 
                                     lmode = lmode,
                                     tmode = tmode)
}