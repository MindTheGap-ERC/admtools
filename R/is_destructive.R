is_destructive = function(adm, t, mode = "rcll", bdry_pts_hiat = "destructive", out_dom_mode = "default"){
  
  #'
  #' @title Is deposition destructive?
  #' 
  #' @param adm an adm object
  #' @param t vector of times
  #' @param mode string, either "rcll", "lcrl", "open", or "closed"
  #' @param bdry_pts_hiat string, "destructive" or "consistent". If the adm starts/ends with a hiatus, should the 
  #' start/end be removed, or treated consistently with mode?
  #' @param out_dom_mode ""default", "destructive", or "conservative" 
  #' 
  #' @returns logical vector of same length as t. Is deposition at time t destructive?
  #' 
  #' 
  
  stopifnot(bdry_pts_hiat %in% c("destructive", "consistent"))
  
  if (out_dom_mode == "default"){
    yleft = NA
    yright = NA
  } else if (out_dom_mode == "destructive") {
    yleft = 1
    yright = 1
  } else if (out_dom_mode == "conservative"){
    yleft = 0
    yright = 0
  } else{
    stop("invalid option for out_dom_mode")
  }
  
  is_start_time = function(adm, t){
    res = rep(FALSE, length(t))
    res = replace(res, t == min(adm$t), TRUE)
    return(res)
  }
  
  is_end_time = function(adm, t){
    res = rep(FALSE, length(t))
    res = replace(res, t == max(adm$t), TRUE)
    return(res)
  }
  
  starts_with_hiatus = function(adm){
    return(adm$h[1]==adm$h[2])
  }
  ends_with_hiatus = function(adm){
    return(adm$h[length(adm$h) - 1]==adm$h[length(adm$h)])
  }
  
  if (mode == "rcll"){
    is_destructive = as.logical(stats::approx(x = adm$t,
                                       y = c(adm$destr,0),
                                       method = "constant",
                                       ties = "ordered",
                                       f = 0,
                                       xout = t,
                                       yleft = yleft,
                                       yright = yright)$y)
    if (bdry_pts_hiat == "destructive"){
      if(starts_with_hiatus(adm)){
        is_destructive = replace(is_destructive, is_start_time(adm, t), TRUE)
      }
      if(ends_with_hiatus(adm))
        is_destructive = replace(is_destructive, is_end_time(adm, t), TRUE)
    }
    return(is_destructive)
  }
  if (mode == "lcrl") {
    is_destructive = as.logical(stats::approx(x = adm$t,
                                       y = c(0,adm$destr),
                                       method = "constant",
                                       ties = "ordered",
                                       f = 1,
                                       xout = t,
                                       yleft = yleft,
                                       yright = yright)$y)
    if (bdry_pts_hiat == "destructive"){
      if(starts_with_hiatus(adm)){
        is_destructive = replace(is_destructive, is_start_time(adm, t), TRUE)
      }
      if(ends_with_hiatus(adm))
        is_destructive = replace(is_destructive, is_end_time(adm, t), TRUE)
    }
    return(is_destructive)
  }
  
  if (mode == "open") {
    is_destructive = is_destructive(adm = adm, t = t, mode = "rcll", bdry_pts_hiat = bdry_pts_hiat , out_dom_mode = "default") & is_destructive(adm = adm, t = t, mode = "lcrl" , bdry_pts_hiat = bdry_pts_hiat , out_dom_mode = "default")
    return(is_destructive)
  }
  
  if (mode == "closed") {
    is_destructive = is_destructive(adm = adm, t = t, mode = "rcll" , bdry_pts_hiat = bdry_pts_hiat , out_dom_mode = "default") | is_destructive(adm = adm, t = t, mode = "lcrl" , bdry_pts_hiat = bdry_pts_hiat , out_dom_mode = "default")
    return(is_destructive)
  }

stop("unknown mode")


}
