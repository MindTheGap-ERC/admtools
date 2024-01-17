plot.sac = function(x, ...){
  #' @export
  #' 
  #' @title plot sediment accumulation curve
  #' 
  #' @param x object of class _sac_
  #' @param ... further parameters (currently ignored)
  #' 
  #' @returns invisible NULL
  
  plot(x$t, x$h, type = "l")
}