get_height.adm = function(x, t, destructive = TRUE, out_dom_val_h = "default", ...){
  
  #' 
  #' @export
  #' 
  
  adm = x
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
