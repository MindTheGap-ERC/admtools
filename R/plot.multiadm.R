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
                      "madm" = x),
         envir = .adm_plot_env)
  

  
  make_adm_canvas()
  
  if (mode == "lines") {
    for ( i in seq_len(no_of_entries)){
      graphics::lines(multiadm$t[[i]], multiadm$h[[i]])
    }
  }
  
  if (mode == "envelope"){

    
    h = seq(h_min, h_max, length.out = 100)
    h_list = get_time(multiadm, h)
    h_t= list()
    for ( i in seq_len(100)){
      h_t[[i]] = sapply(h_list, function(x) x[i])
    }
    graphics::lines(sapply(h_t, function(x) stats::quantile(x, 0.025, na.rm = TRUE)),h, col = "blue")
    graphics::lines(sapply(h_t, function(x) stats::quantile(x, 0.975, na.rm = TRUE)),h, col = "blue")
    graphics::lines(sapply(h_t, function(x) stats::quantile(x, 0.5, na.rm = TRUE)),h, col = "red")
  }

  
}
