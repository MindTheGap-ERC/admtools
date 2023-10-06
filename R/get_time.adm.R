get_time.adm = function(adm, h, hiat_mode = "start", bdry_pts_hiat = "destructive", out_dom_val_t = "default"){
  
  #' 
  #' @title Determine times based on age-depth model
  #' 
  #' @description
    #' Takes an age-depth model and vector of stratigraphic positions to determine
    #' the corresponding time of formation
    #' 
  #' 
  #' @usage get_time(adm, h, hiat_mode = "start", bdry_pts_hiat = "destructive", out_dom_val_t = "default")
  #' 
  #' @param adm an adm object
  #' @param h vector of stratigraphic positions
  #' @param hiat_mode "start", "end", or "destroy". If a stratigraphic position coincides with a hiatus, what should be returned?
  #' @param bdry_pts_hiat "consistent" or "destructive". How are hiatuses at the start/end of the adm treated?
  #' @param out_dom_val_t :"default", "time_limits", or a numeric value. What value is returned for heights not covered by the age-depth model?
  #' 
  #' @details
    #'  If a stratigraphic position
    #' coincides with a hiatus, should the start time or the end time of the hiatus be returned? 
    #' Using "destroy" retruns NA
    #'If the adm starts/ends with a hiatus, should
  #' the time returned be consistent with _hiat_mode_, or should it be NA?
  #' 
  #' @export
  
  stopifnot(bdry_pts_hiat %in% c("consistent", "destructive"))
  if (out_dom_val_t[1] == "default"){
    yleft = NA
    yright = NA
  } else  if (out_dom_val_t[1] == "time_limits"){
    yleft = min(adm$t)
    yright = max(adm$t)
  } else {
    out_dom_val_t = rep(out_dom_val_t, 2)
    yleft = out_dom_val_t[1]
    yright = out_dom_val_t[2]
  }
  
  is_start_strat = function(adm, h){
    res = rep(FALSE, length(h))
    res = replace(res, h == min(adm$h), TRUE)
    return(res)
  }
  
  is_end_strat = function(adm, h){
    res = rep(FALSE, length(h))
    res = replace(res, h == max(adm$h), TRUE)
    return(res)
  }
  
  starts_with_hiatus = function(adm){
    return(adm$h[1]==adm$h[2])
  }
  ends_with_hiatus = function(adm){
    return(adm$h[length(adm$h) - 1]==adm$h[length(adm$h)])
  }
  
  if(hiat_mode == "start"){
    time = stats::approx(x = adm$h,
                         y = adm$t,
                         method = "linear",
                         yleft = yleft,
                         yright = yright,
                         ties = list("ordered",min),
                         xout = h)$y
    
    if (bdry_pts_hiat == "destructive"){
      if (starts_with_hiatus(adm)){
        time = replace(time, is_start_strat(adm, h), NA)
      }
      if (ends_with_hiatus(adm)){
        time = replace(time, is_end_strat(adm, h), NA)
      }
      
    }
    return(time)
  }
  if (hiat_mode == "end"){
    time = stats::approx(x = adm$h,
                         y = adm$t,
                         method = "linear", 
                         yleft = yleft,
                         yright = yright,
                         ties = list("ordered",max),
                         xout = h)$y
    if (bdry_pts_hiat == "destructive"){
      if (starts_with_hiatus(adm)){
        time = replace(time, is_start_strat(adm, h), NA)
      }
      if (ends_with_hiatus(adm)){
        time = replace(time, is_end_strat(adm, h), NA)
      }
    }
    return(time)
  }
  if (hiat_mode == "destroy"){
    time_start = get_time(adm = adm,
                          h = h,
                          hiat_mode = "start",
                          bdry_pts_hiat = bdry_pts_hiat,
                          out_dom_val_t = out_dom_val_t)
    time_end = get_time(adm = adm,
                        h = h,
                        hiat_mode = "end",
                        bdry_pts_hiat = bdry_pts_hiat,
                        out_dom_val_t = out_dom_val_t)
    time = replace(x = time_start,
                   list = time_start != time_end,
                   values = NA)
    
    return(time)
  }
  stop("Did not find hiat_mode")
  
}

