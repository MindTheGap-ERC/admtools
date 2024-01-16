tp_float = function(){
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
