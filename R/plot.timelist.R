plot.timelist = function(x, ...){
  #' @export
  #'
  #' @title plot time lists
  #'
  #' @param x a time list
  #' @param ... other options passed to plot
  #'
  plot(x$t, x$y, ...)
}
