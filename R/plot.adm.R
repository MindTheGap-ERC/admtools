plot.adm = function(x, lwd_destr = 1, lwd_acc = 1, lty_destr = 3, lty_acc = 1, 
                    col_destr = "black", col_acc = "black", ...){
  
  #'
  #'@export
  #'
  #' @title plotting adm objects
  #' 
  #' @param x an adm object
  #' @param lwd_destr line width of hiatuses
  #' @param lwd_acc line width of conservative intervals
  #' @param lty_destr linetype of hiatuses
  #' @param lty_acc line type of conservative intervals
  #' @param col_destr color of erosive intervals
  #' @param col_acc color of conservative intervals
  #' @param ... arguments passed to plot
  #' 
  #' @seealso [L_axis_lab()] and [T_axis_lab()] for plotting time and axis labels, the vignette on plotting available via `browseVignettes(package = "admtools")`
  #' 
  
  assign(x = "adm_plot_info",
         value = list("T_unit" = x$T_unit,
                      "L_unit" = x$L_unit,
                      "h_range" = range(x$h),
                      "t_range" = range(x$t),
                      "adm" = x),
         envir = .adm_plot_env)
  
  adm = x
  
  in_list = list(...)
  
  make_adm_canvas()
  

  
  # non-erosive parts
  plot_acc_parts(lwd_acc = lwd_acc, lty_acc = lty_acc, 
                            col_acc = col_acc)
  
  # erosive parts
  plot_destr_parts(lwd_destr = lwd_destr, lty_destr = lty_destr, col_destr = col_destr)
  
  return(invisible())
  
}
  

