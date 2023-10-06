get_height.adm = function(adm, t, destructive = TRUE, out_dom_val_h = "default", ...){
  
  #'
  #' @title determine stratigraphic height deposited at specific time
  #' 
  #' @description
    #' Takes an adm object and a vector of times, and returns the stratigraphic
    #' heights deposited at said times
    #' 
  #' 
  #' @usage get_height(adm, t, destructive = TRUE, out_dom_val_h = "default", ...)
  #' 
  #' @param adm an _adm_ object
  #' @param t vector of times
  #' @param destructive logical - should destructive intervals be considered? See Details
  #' @param out_dom_val_h "strat_limits", "default", or a vector with one or two entries. What value is assigned to times that are not covered by the age-depth model? 
  #' @param ... parameters handed over to is_destructive
  #' 
  #' @details
    #' if destructive is true, NA is returned for times that coincide with
    #' destructive intervals. This is achieved by calling _is_destructive_ with
    #' arguments passed by _..._. 
    #' 
    #' _out_dom_val_ specified the return value for times that are not covered by the 
    #' age-depth model. For "default", NA is returned. For "strat_limits", the lowest
    #' resp. highest stratigraphic position is returned. For a vector of length one, this value is assigned 
    #' to both sides. For a vector or length 2 or more, the first and second entries are assigned on the left (resp. right) side
    #' 
    #' 
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
