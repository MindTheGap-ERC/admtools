identify_constructor = function(input_args_raw) {
  sed_rate_synonyms = c("s", "sed", "srate", "sedrate", "sedimentation", 
                        "sedimentationrate", "sedimentation_rate", 
                        "sedimentation rate")
  condensation_synonyms = c("c", "cond", "condensation")
  time_synonyms = c("t", "time")
  age_synonyms = c("a", "age")
  height_synonyms = c("h", "height", "strat", "strat height", "stratheight", 
                      "strat_height")
  depth_synonyms = c("d", "depth")
  
  #names of input variables (vase insensityve)
  input_var_names = tolower(names(input_args_raw))
  
  sed_rate_input=input_var_names %in% sed_rate_synonyms
  cond_input = input_var_names %in% condensation_synonyms
  time_input = input_var_names %in% time_synonyms
  age_input = input_var_names %in% age_synonyms
  height_input = input_var_names %in% height_synonyms
  depth_input = input_var_names %in% depth_synonyms
  
  input_type_duplicated = sapply(
    list(sed_rate_input, condensation_input, time_input, age_input, height_input, depth_input), 
    function(x) sum(x) == 2
    )
  if(any(input_type_duplicated)){
    stop("input types duplicatd")
  }
  
  if(any(time_input) & any(height_input)){
    tmode="time"
    lmode="height"
    
  } else if(any(time_input) & any(depth_input)){
    tmode="time"
    lmode="depth"
    
  } else if(any(age_input) & any(height_input)){
    tmode="age"
    lmode="height"
    
  } else if(any(age_input) & any(depth_input)){
    tmode="age"
    lmode="depth"
    
  }
  
  return(input_args_formatted)
}