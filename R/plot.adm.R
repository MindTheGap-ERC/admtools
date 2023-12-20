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
  #' @param ... arguments passed to plot
  #' 
  
  assign("adm_plot_info",list("T_unit" = x$T_unit,
                              "L_unit" = x$L_unit), envir = .adm_plot_env)
  
  adm = x
  
  in_list = list(...)
  
  plot(x = adm$t,
       y = adm$h,
       type = "l",
       lty = "blank",
       xlab = "",
       ylab = "",
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
  

