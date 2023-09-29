is_destructive = function(adm, t, mode = "rcll", bdry_hiat = "destructive", outside_domain = "default"){
  #'
  #' @title Is deposition destructive?
  #' 
  #' @param adm an adm object
  #' @param t vector of times
  #' @param mode string, either "rcll", "lcrl", "open", or "closed"
  #' @param bdry_hiat string, "destructive" or "consistent". If the adm starts/ends with a hiatus, should the 
  #' start/end be removed, or treated consistently with mode?
  #' @param ouside_domain NA, FALSE, or TRUE. Value assigned to times not covered by the adm 
  #' 
  #' @returns logical vector of same length as t. Is deposition at time t destructive?
  #' 
  #' 
  
  if (outside_domain == "default"){
    yleft = NA
    yright = NA
  } else if (outside_domain == "destructive") {
    yleft = 1
    yright = 1
  } else if (outside_domain == "conservative"){
    yleft = 0
    yright = 0
  } else{
    stop("invalid optino for outside_domain")
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
                                       y = c(adm$destr,adm$destr[length(adm$destr)]),
                                       method = "constant",
                                       ties = "ordered",
                                       f = 0,
                                       xout = t,
                                       yleft = yleft,
                                       yright = yright)$y)
    if (bdry_hiat == "destructive"){
      if(starts_with_hiatus(adm)){
        is_destructive = replace(is_destructive, is_start_time(adm, t), NA)
      }
      if(ends_with_hiatus(adm))
        is_destructive = replace(is_destructive, is_end_time(adm, t), NA)
    }
    return(is_destructive)
  }
  if (mode == "lcrl") {
    is_destructive = as.logical(stats::approx(x = adm$t,
                                       y = c(adm$destr[1],adm$destr),
                                       method = "constant",
                                       ties = "ordered",
                                       f = 1,
                                       xout = t,
                                       yleft = yleft,
                                       yright = yright)$y)
    if (bdry_hiat == "destructive"){
      if(starts_with_hiatus(adm)){
        is_destructive = replace(is_destructive, is_start_time(adm, t), NA)
      }
      if(ends_with_hiatus(adm))
        is_destructive = replace(is_destructive, is_end_time(adm, t), NA)
    }
    return(is_destructive)
  }
  
  if (mode == "open") {
    is_destructive = is_destructive(adm = adm, t = t, mode = "rcll", bdry_hiat = bdry_hiat , outside_domain = "default") & is_destructive(adm = adm, t = t, mode = "lcrl" , bdry_hiat = bdry_hiat , outside_domain = "default")
    return(is_destructive)
  }
  
  if (mode == "closed") {
    is_destructive = is_destructive(adm = adm, t = t, mode = "rcll" , bdry_hiat = bdry_hiat , outside_domain = "default") | is_destructive(adm = adm, t = t, mode = "lcrl" , bdry_hiat = bdry_hiat , outside_domain = "default")
    return(is_destructive)
  }

stop("unknown mode")


}
