get_height = function(adm, t, destructive = TRUE){
  
  #'
  #' @title determine stratigraphic height deposited at specific time
  #' 
  #' @param adm adm object
  #' @param t vector of times
  #' @param destructive logical. if true, returns NA for times that coincide with destructive intervals
  #' 
  #' @return a vector with same length as t, containing the strat heights deposited
  #' 
  height = stats::approx(x = adm$t,
                  y = adm$h,
                  xout = t)$y
  if (destructive){
    is_destr = is_destructive(adm,t)
    height[is_destr] = NA
  }
  
  return(height)
}
