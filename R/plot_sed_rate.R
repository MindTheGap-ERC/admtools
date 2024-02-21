plot_sed_rate_t = function(x,mode = "rcll"){
  #' @export
  #' 
  #' @title plot sedimentation rate in time
  #' 
  #' @param x adm object
  #' @param mode string, "rcll" or "lcrl". Should the sedimentation rate be Right Continuous with Left Limits (rcll) or Left Continuous with Right Limits (lcrl)
  #' 
  #' @returns invisible NULL
  t = x$t
  val = sed_rate_t.adm(x, t, mode)
  
  plot(t,val, type = "l",
       xlab = "Time",
       ylab = "Sedimentation Rate")
  
  return(invisible())
}

plot_sed_rate_l = function(x, h = "default" , mode = "rcll", ...){
  #' @export
  #' 
  #' @title plot sed. rate in height
  #' 
  #' @param x an adm object
  #' @param h "default" or a numeric vector of height where the sed rate is evaluated
  #' @param mode string, handed over to _sed_rate_t_, see ?sed_rate_t for details
  #' @param ... parameters passed to _get_time_, see ?get_time for details
  #' 
  #' @returns invisible null
  if (h[1] == "default"){
    h = x$h
  }
  val = sed_rate_l.adm(x,h,mode)
  
  plot(x = val,
       y = h,
       type = "l",
       xlab = "Sedimentation Rate",
       ylab = "Height")
  
  return(invisible())
}

