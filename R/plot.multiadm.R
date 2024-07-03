plot.multiadm = function(x, ...){
  
  #'
  #' @export
  #' 
  #' @title plot multiadm object
  #' 
  #' @param x multiadm object
  #' @param ... parameters passed to `plot`
  #' 
  #' @returns a plot of the multiadm object
  #' 
  
  
  
  
  arg_list = list(...)
  
  move_multiadm_to_env(x)
  
  multiadm = x
  
  make_adm_canvas()
  
  plot_envelope()

  
}

move_multiadm_to_env = function(x, ...){
  
  #' 
  #' @keywords internal
  #' @noRd
  #' 
  #' @title moves multiadm to environments
  #' 
  #' @description
    #' Moves the params used for plotting into the plotting environment
  #'
  #' @param x multiadm object
  #' @param ... further plotting parameters
  #' 
  #' @returns invisible NULL
  #' 
  
  multiadm = x
  
  no_of_entries = multiadm$no_of_entries
  t_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["t"]][[x]])), na.rm = TRUE)
  t_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["t"]][[x]])), na.rm = TRUE)
  h_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["h"]][[x]])), na.rm = TRUE)
  h_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["h"]][[x]])), na.rm = TRUE)
  
  assign(x = "adm_plot_info",
         value = list("T_unit" = x$T_unit,
                      "L_unit" = x$L_unit,
                      "h_range" = c(h_min, h_max),
                      "t_range" = c(t_min, t_max),
                      "median_col" = "red",
                      "envelope_col" = "blue",
                      "p_envelope" = 0.9,
                      "madm" = x),
         envir = .adm_plot_env)
  return(invisible())
}

plot_envelope = function(){
  
  #' 
  #' @keywords internal
  #' @noRd
  #' 
  #' @title plot envelope for multiadm
  #' 
  #' @returns invisible NULL
  #' 
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  
  multiadm = list$madm
  
  h = seq(list$h_range[1], list$h_range[2], length.out = 100)
  
  q1 = quantile_adm(multiadm, h, 0.025)
  q2 = quantile_adm(multiadm, h, 0.975)
  me = median_adm(multiadm, h)
  graphics::lines(q1$t, q1$h, col = list$envelope_col)
  graphics::lines(q2$t, q2$h, col = list$envelope_col)
  graphics::lines(me$t, me$h, col = list$median_col)
  
  return(invisible())
}

make_legend = function(){
  #' @export
  #' 
  #' @title plot legend
  #' 
  #' @description
    #' plots a legend for the multiadm plot
    #' 
  #' 
  #' @returns invisible NULL
  #' 
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  graphics::legend("topleft",
         lwd = 1,
         lty = 1,
         col = c(list$median_col, list$envelope_col),
         legend = c("Median", paste0(list$p_envelope, " Percentile Envelope" )))
}
