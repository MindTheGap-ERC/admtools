plot_erosive_intervals = function(density = NULL, angle = 45, col = "azure3", border = NA,
                                  lty = 1, lwd = 1){
  
  #'
  #' @export
  #' 
  #' @title mark erosive time intervals
  #' 
  #' @param density parameter passed to _rect_, see ?rect for details
  #' @param angle parameter passed to _rect_, see ?rect for details
  #' @param col parameter passed to _rect_, see ?rect for details
  #' @param border parameter passed to _rect_, see ?rect for details
  #' @param lty parameter passed to _rect_, see ?rect for details
  #' @param lwd parameter passed to _rect_, see ?rect for details
  #' 
  #' @returns invisible NULL
  #' 
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  
  x = list$adm
  
  hiat_list = get_hiat_list(x)
  
  y_max = max(x$h)
  y_min = min(x$h)
  
  for (i in seq_along(hiat_list)){
    graphics::rect(xleft = hiat_list[[i]]["start"],
                   xright = hiat_list[[i]]["end"],
                   ytop = y_max,
                   ybottom = y_min,
                   density = density,
                   angle = angle,
                   col = col,
                   border = border,
                   lty = lty,
                   lwd = lwd)
  }
  return(invisible())
}