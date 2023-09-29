get_height.adm = function(adm, t, destructive = TRUE, outside_domain = "default", ...){
  
  #'
  #' @title determine stratigraphic height deposited at specific time
  #' 
  #' @param adm adm object
  #' @param t vector of times
  #' @param destructive logical. if true, returns NA for times that coincide with destructive intervals
  #' @param outside_domain value assigned to values outside of the domain. If "strat_limits", outputs are limited to max/min depth of strat height
  #' @param ... parameters handed over to is_destructive
  #' 
  #' @return a vector with same length as t, containing the strat heights deposited
  #' 
  #' 
  
  if (outside_domain == "strat_limits"){
    yleft = min(adm$h)
    yright = max(adm$h)
  } else if (outside_domain == "default") {
    yleft = NA
    yright = NA
  }  else{
    yleft = outside_domain
    yright = outside_domain
  }
  height = stats::approx(x = adm$t,
                         y = adm$h,
                         xout = t,
                         yleft = yleft,
                         yright = yright,
                         method = "linear")$y
  if (destructive){
    is_destr = is_destructive(adm,t, ...)
    height[is_destr] = NA
  }
  
  return(height)
}
