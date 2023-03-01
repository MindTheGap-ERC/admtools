adm_generator = function(...) {
  # read input
  input_args_raw = list(...)

  # checks no of entries, type check etc

  input_args_formatted = identify_constructor(input_args_raw)
  
  # checks if entries are sufficient to construct adm
  adm = dispatch_to_adm_constructors(input_args_formatted)
  
  return(adm)
}