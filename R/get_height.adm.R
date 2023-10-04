get_height.adm = function(adm, t, destructive = TRUE, out_dom_val_h = "default", ...){
  
  #'
  #' @title determine stratigraphic height deposited at specific time
  #' 
  #' @param adm adm object
  #' @param t vector of times
  #' @param destructive logical. if true, returns NA for times that coincide with destructive intervals
  #' @param out_dom_val_h value assigned to values outside of the domain. If "strat_limits", outputs are limited to max/min depth of strat height
  #' @param ... parameters handed over to is_destructive
  #' 
  #' @return a vector with same length as t, containing the strat heights deposited
  #' 
  #' @export
  
  if (out_dom_val_h[1] == "strat_limits"){
    yleft = min(adm$h)
    yright = max(adm$h)
  } else if (out_dom_val_h[1] == "default") {
    yleft = NA
    yright = NA
  }  else{
    out_dom_val_h = rep(out_dom_val_h, 2)
    yleft = out_dom_val_h[1]
    yright = out_dom_val_h[2]
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
