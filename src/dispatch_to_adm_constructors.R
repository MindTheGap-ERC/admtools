dispatch_to_adm_constructors = function(input_args_formatted) {
  #' Hands over pre-processes input data and hands if over to the corresponding
  #' adm constructor
  #' 
  #' 
  construction_method = input_args_formatted$construction_method
  
  
  adm = switch(
    construction_method,
    "tie_points_to_adm" = tie_points_to_adm(
      t_dim_in = input_args_formatted$t, 
      l_dim_in = input_args_formatted$l,
      tmode = input_args_formatted$tmode,
      lmode = input_args_formatted$lmode),
    "pc_sed_to_adm_time_domain" = pc_sed_to_adm_time_domain(
      t_dim_in = input_args_formatted$t, # tie points in time domain
      sed_rate = input_args_formatted$sed_rate, # sed rate
      tmode = input_args_formatted$tmode), # "time" or "age"
    stop("COuld not find construction method for Age-Depth model")
  )
  return(adm)
}