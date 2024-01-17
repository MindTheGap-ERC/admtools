plot_destr_parts = function(lwd_destr = 1, lty_destr = 3, col_destr = "black"){
  
  #'
  #' @keywords internal
  #' @noRd
  #' 
  #' @title draw destr. intervals
  #' 
  #' @description
  #' draws time intervals no sediment is accumulated and signals are destroyed
  #'
  #' @param lwd_destr line width
  #' @param lty_destr line type
  #' @param col_destr color
  #' 
  #' @returns invisible NULL
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  
  x = list$adm
  
  for ( i in seq_along(x$destr)){
    if (x$destr[i]){
      graphics::lines(x = c(x$t[c(i, i+1)]),
                      y = c(x$h[c(i, i+1)]),
                      col = col_destr,
                      lwd = lwd_destr,
                      lty = lty_destr)
    }
  }
  return(invisible())
}