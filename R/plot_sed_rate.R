plot_sed_rate_t = function(x,mode = "rcll"){
  #' @export
  #' 
  #' @title plot sedimentation rate
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

