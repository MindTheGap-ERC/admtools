plot.adm = function(x, lwd_hiat = 1, lwd_cons = 1, lty_hiat = 3, lty_cons = 1, 
                    col_hiat = "black", col_cons = "black", ...){
  
  #'
  #'@export
  #'
  #' @title plotting adm objects
  #' 
  #' @param x an adm object
  #' @param lwd_hiat line width of hiatuse
  #' @param lwd_cons line width of conservative intervals
  #' @param lty_hiat linetype of hiatuses
  #' @param lty_cons line type of conservative intervals
  #' @param col_hiat color of erosive intervals
  #' @param col_cons color of conservative intervals
  #' 
  
  adm = x
  
  in_list = list(...)
  
  if ("xlab" %in% names(in_list)){
    xlab = in_list[["xlab"]]
  } else {
    if (is.null(adm$T_unit)) {
      xlab = "Time"
    } else {
      xlab = paste0("Time [", adm$T_unit, "]") 
    }
  }
  
  if ("ylab" %in% names(in_list)){
    ylab = in_list[["ylab"]]
  } else {
    if (is.null(adm$L_unit)) {
      ylab = "Height"
    } else {
      ylab = paste0("Height [", adm$L_unit, "]") 
    }
  }
  
  plot(x = adm$t,
       y = adm$h,
       type = "l",
       lty = "blank",
       xlab = xlab,
       ylab = ylab,
       ...)
  

  
  # non-erosive parts
  x = replace(adm$t, is_destructive(adm, adm$t, mode = "open"), NA)
  y = replace(adm$h, is_destructive(adm, adm$t, mode = "open"), NA)
  graphics::lines(x = x, y = y,
                  lwd = lwd_cons,
                  lty = lty_cons,
                  col = col_cons)
  
  # erosive parts
  x= replace(adm$t, ! is_destructive(adm, adm$t, mode = "closed"), NA)
  y= replace(adm$h, ! is_destructive(adm, adm$t, mode = "closed"), NA)
  graphics::lines(x, y, lwd = lwd_hiat, lty = lty_hiat, col = col_hiat)
  
}
  

