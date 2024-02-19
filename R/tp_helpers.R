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

tp_time_norm = function(mean, sd, force_order = TRUE){
  #' @export
  #' 
  #' @title time tie points with normal distribution
  #' 
  #' @description
    #' defines a function factory that returns normally distributed times. FOr usage with `sedrate_to_multiadm` and `strat_cont_to_multiadm`.
    #' 
  #' @param mean numeric vector, mean age of tie points
  #' @param sd numeric vector, standard deviation of tie points
  #' @param force_order logical, enforce strictly increasing times
  #' 
  #' @returns a function
  if (!force_order){
    f = function(){
      return(rnorm(n = length(mean), mean = mean, sd = sd))
    }
    return(f)
  }
  
  f = function(){
    i = 1
    repeat{
      t = rnorm(n = length(mean), mean = mean, sd = sd)
      if (!is.unsorted(t)){
        break
      }
      i = i+1
      if (i >1000){
        stop("COuld not find strictly increasing sample")
      }
    }
    return(t)
  }
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