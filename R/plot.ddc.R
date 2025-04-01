plot.ddc = function(x, ...){
  #' @export
  #' 
  #' @title plot depth-depth curve
  #' 
  #' @param x depth-depth curve
  #' @param ... other parameters passed to plot
  #' 
  plot(x = x$h1,
       y = x$h2,
       ...)
}