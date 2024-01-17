plot_acc_parts = function(lwd_acc = 1, lty_acc = 1, 
                          col_acc = "black"){
  
  #'
  #' @keywords internal
  #' @noRd
  #' 
  #' @title draw sed accumulation
  #' 
  #' @description
    #' draws time intervals where sediment is accumulated
  #'
  #' @param lwd_acc line width
  #' @param lty_acc line type
  #' @param col_acc color
  #' 
  #' @returns invisible NULL
  
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  
  x = list$adm
  
  for ( i in seq_along(x$destr)){
    if (!x$destr[i]){
      graphics::lines(x = c(x$t[c(i, i+1)]),
                      y = c(x$h[c(i, i+1)]),
                      col = col_acc,
                      lwd = lwd_acc,
                      lty = lty_acc)
    }
  }
  return(invisible())
}