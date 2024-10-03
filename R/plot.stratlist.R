plot.stratlist = function(x, orientation = "du", ord_name = "y", ...){
  
  #' @export
  #'
  #' @title plot strat list
  #'
  #' @param x stratlist object
  #' @param orientation character, either "du" (down-up) or "lr" (left-right). Orientation of plotting
  #' @param ord_name name of the ordinate. Values plotted against time
  #' @param ... further arguments passed to plot
  #' 
  #' @description
    #' plots a `stratlist`, i.e. a list of values associated with stratigraphic positions (typically returned by time_to_strat). will plot the element with matching `ord_name` against stratigraphic positions.
    #' 
  #' 
  if (!(ord_name %in% names(x))){
    stop("no matching ordinate name found")
  }
  
  if (orientation == "du"){
    plot(x[[ord_name]], x$h, ...)
    return(invisible())
  }
  if (orientation == "lr"){
    plot(x$h, x[[ord_name]], ...)
    return(invisible())
  }
  stop("Unknown option for \"orientation\". Use either \"ud\" or \"lr\".")
}
