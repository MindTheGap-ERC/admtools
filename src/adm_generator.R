adm_generator = function(...) {
  # read input
  input_args = list(...)

  # checks no of entries, type check etc
  first_input_check(input_args)
  
  units = get_units(input_args)
  
  construction_method = get_adm_construction_method(input_args)
  
  # checks if entries are sufficient to construct adm
  second_input_check(input_args, units, construction_method)
  
  adm = switch(
    construction_method,
    "method 1" = blblb,
    "method 2" = blblb,
    stop("Construction method for age-depth model not recognized")
  )
  
  return(adm)
}