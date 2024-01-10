plot.multiadm = function(x,...){
  
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
   
  if ("mode" %in% names(arg_list)){
    if (arg_list[["mode"]] == "envelope"){
      mode = "envelope"
    } else {
      mode = "lines"
    }
  } else {
    mode = "lines"
  }
  
  move_multiadm_to_env(x)
  
  multiadm = x
  
  make_adm_canvas()
  
  if (mode == "lines") {
    for ( i in seq_len(multiadm$no_of_entries)){
      graphics::lines(multiadm$t[[i]], multiadm$h[[i]])
    }
  }
  
  if (mode == "envelope"){
    plot_envelope()
    
    
  }

  
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
  t_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["t"]][[x]])))
  t_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["t"]][[x]])))
  h_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["h"]][[x]])))
  h_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["h"]][[x]])))
  
  assign(x = "adm_plot_info",
         value = list("T_unit" = x$T_unit,
                      "L_unit" = x$L_unit,
                      "h_range" = c(h_min, h_max),
                      "t_range" = c(t_min, t_max),
                      "median_col" = "red",
                      "envelope_col" = "blue",
                      "p_envelope" = 0.95,
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
  h_list = get_time(multiadm, h)
  h_t= list()
  for ( i in seq_len(100)){
    h_t[[i]] = sapply(h_list, function(x) x[i])
  }
  graphics::lines(sapply(h_t, function(x) stats::quantile(x, 0.5 * (1 - list$p_envelope) , na.rm = TRUE)),h, col = list$envelope_col)
  graphics::lines(sapply(h_t, function(x) stats::quantile(x, 0.5 * (1 - list$p_envelope) + list$p_envelope, na.rm = TRUE)),h, col = list$envelope_col)
  graphics::lines(sapply(h_t, function(x) stats::quantile(x, 0.5, na.rm = TRUE)),h, col = list$median_col)
  
  return(invisible())
}

make_legend = function(){
  #' @export
  #' 
  #' @title plot legend
  #' 
  #' @returns invisible NULL
  #' 
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  legend("topleft",
         lwd = 1,
         lty = 1,
         col = c(list$envelope_col, list$median_col),
         legend = c("Median", paste0(list$p_envelope, " Percentile Envelope" )))
}
