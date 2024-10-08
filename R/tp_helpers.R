tp_time_floating_scale = function(){
  #' @export
  #' 
  #' @title tie points for floating time scale
  #' 
  #' @description
    #' Defines tie points for a floating (auxiliary) time scale for usage with _sedrate_to_multiadm_ and _strat_cont_to_multiadm_ as t_tp input. This floating time scale consists of two tie points in time, the first at time t = 0, the second at time t = 1. `tp_time_floating_scale` is a synonym of  `tp_time_det(times = c(0,1))`
    #' 
  #' @returns  function for usage with _strat_cont_to_multiadm_ and _sedrate_to_multiamd_ as t_tp input
  #' 
  #' @seealso [tp_time_norm()] for tie points following a normal distribution, [tp_height_det()] for deterministic height tie points
  #'
  #' @examples
  #' \dontrun{
  #' # see this vignette for an example
  #' vignette("adm_from_trace_cont")
  #' } 
  
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
  #' @seealso [tp_time_floating_scale()] for tie points for a floating scale, [tp_height_det()] for deterministic height tie points
  #' 
  #' @returns  function for usage with _strat_cont_to_multiadm_ and _sedrate_to_multiamd_ as t_tp input
  if (!force_order){
    f = function(){
      return(stats::rnorm(n = length(mean), mean = mean, sd = sd))
    }
    return(f)
  }
  
  f = function(){
    i = 1
    repeat{
      t = stats::rnorm(n = length(mean), mean = mean, sd = sd)
      if (!is.unsorted(t)){
        break
      }
      i = i+1
      if (i >1000){
        stop("Could not find strictly increasing sample")
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
  #' @seealso [tp_time_det()] for deterministic tie points in time, [tp_time_norm()] for tie points following a normal distribution, [tp_time_floating_scale()] for tie points for a floating scale,
  #' 
  #' @returns a function for usage with _strat_cont_to_multiadm_ and _sedrate_to_multiamd_ as h_tp input
  if (is.unsorted(heights, strictly = TRUE)){
    stop("Need strictly increasing heights")
  }
  f = function() return(heights)
  return(f)
}

tp_time_det = function(times){
  #' @export
  #' 
  #' @title deterministic tie points in time domain
  #' 
  #' @description
    #' defines deterministic tie points in time. 
    #' 
  #' @param times numeric vector, times of the tie points
  #' 
  #' @seealso [tp_height_det()] for deterministic tie points in height, [tp_time_norm()] for tie points following a normal distribution 
  #' 
  #' @returns a function for usage with _strat_cont_to_multiadm_ and _sedrate_to_mulitadm_ as t_tp input
  #' 
  if (is.unsorted(times, strictly = TRUE)){
    stop("Need strictly increasing times")
  }
  f = function() return(times)
  return(f)
}