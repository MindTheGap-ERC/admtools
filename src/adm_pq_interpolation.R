source("src/utility_functions.R")

pl_sed_rate_to_adm = function(t, 
                              y, 
                              tmode) { # "age" or "time"
  
  if (tmode == "age") {
    time = age_to_time(age = t)
  }
  if (tmode == "time") {
    time = t
  }
  
  out = parallel_sorting(x = time,
                         y = y)
  
  time = out$x
  sed_rate = out$y
  
  out = add_roots_pl(x = time,
                     y = sed_rate)
  
  time = out$x
  sed_rate = out$y
  
  acc_height = accumulate_increments(x = time,
                                   y = sed_rate,
                                   mode = "pl")
  
  adm = list(tpoints = time, 
             lpoints = acc_height, 
             interpol_mode = "piecewise_cubic",
             lmode = "height", 
             tmode = tmode,
             interpol_data = sed_rate)
  
  return(adm)
  
}