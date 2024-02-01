tp_time_floating_scale = function(){
  #' @export
  #' 
  #' @title tie points for floating time scale
  #' 
  #' @description
    #' Defines tie points for a floating time sclae for usage with _sedrate_to_multiadm_ and _strat_cont_to_multiadm_
    #' 
  #' @returns a functional
  #' 
  
  f = function() return(c(0,1))
  return(f)
}

tp_height_det = function(heights){
  #' @export
  #' 
  #' @title deterministic tie points height domain
  #' 
  #' @description
    #' defines deterministic stratigraphic tie points
    #' 
  #' @param heights numeric vector. Stratigraphic positions of the tie points
  #' 
  #' @returns a function for usage with _strat_cont_to_multiadm_ and _sedrate_to_multiamd_
  
  f = function() return(heights)
  return(f)
}