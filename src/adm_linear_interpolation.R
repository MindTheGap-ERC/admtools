source("src/utility_functions.R")

#### tie_points_to_adm ####
# turn tie points in depth/height and time/age into adm

tie_points_to_adm = function(t, # input in time domain, either time or age
                             l, # input in space domain, either depth or height
                             lmode, #"depth" of "height"
                             tmode) { # "time" or "age"
  if (tmode == "time") {
    time = t
  }
  if (tmode == "age") {
    time = age_to_time(age = t)
  }
  
  if (lmode == "height") {
    height = l
  }
  if (lmode == "depth") {
    height = depth_to_height(depth = l)
  }
  out = parallel_sorting(x = time,
                         y = height)
  
  time = out$x
  height = out$y
  
  adm = list(tpoints = time, 
           lpoints = height, 
           interpol_mode = "piecewise_linear",
           lmode = lmode, 
           tmode = tmode
  )
  
  return(adm)
  
}

#### pc_sed_to_adm_time_domain ####
# tunr piecewise ocnstant sed rate in time domain into adm
pc_sed_to_adm_time_domain = function(x, # tie points in time domain
                         y, # sed rate
                         tmode) {# "time" or "age"
  
  if (tmode == "age") {
    time = age_to_time(age = x)
  }
  if (tmode = "time") {
    time = x
  }

  out = parallel_sorting(x = time,
                         y = y)
  
  time = out$x
  sed_rate = out$y
  
  acc_incr =  accumulate_increments(x = time,
                                    y = sed_rate,
                                    mode = "pc")
  
  adm = list(tpoints = time, 
             lpoints = acc_incr, 
             interpol_mode = "piecewise_linear",
             lmode = "height", 
             tmode = tmode)
  
  return(adm)
  
}

#### pc_sed_to_adm_depth_domain ####
# tunr piecewise constant sed rate in strat domain into adm
pc_sed_to_adm_depth_domain = function(x, # tie points in depth domain
                                     y, # sed rate
                                     lmode) {# "time" or "age"
  
  if (lmode == "depth") {
    depth = depth_to_time(depth = x)
  }
  if (lmode = "height") {
    height = x
  }
  
  condensation = sed_rate_to_condensation(y)
  
  out = parallel_sorting(x = height,
                         y = condensation)
  
  height = out$x
  condensation = out$y
  
  acc_time =  accumulate_increments(x = height,
                                    y = condensation,
                                    mode = "pc")
  
  adm = list(tpoints = acc_time, 
             lpoints = heightr, 
             interpol_mode = "piecewise_linear",
             lmode = lmode, 
             tmode = "time")
  
  return(adm)
  
}

#### pc_cond_to_adm ####
# tunr piecewise ocnstant condensation into adm

pc_cond_to_adm = function (l, # length dimension
                           cond, # condensation
                           lmode) { # "depth" or "height"
  if (lmode == "depth") {
    height = depth_to_height(depth = l)
  }
  if (lmode == "height") {
    height = l
  }
  out = parallel_sorting(x = height,
                         y = cond)
  height = out$x
  condensation = out$y
  
  acc_time = accumulate_increments(x = height,
                                   y = condensation,
                                   mode = "pc")
  adm = list(tpoints = acc_time, 
       lpoints = height, 
       interpol_mode = "piecewise_linear",
       lmode = lmode, 
       tmode = "time")
  
}
