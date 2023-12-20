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
    mode == "lines"
  }
  
  assign("adm_plot_info",list("T_unit" = x$T_unit,
                              "L_unit" = x$L_unit), envir = .adm_plot_env)
  
  multiadm = x
  
  if (mode == "lines") {
    no_of_entries = multiadm$no_of_entries
    t_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["t"]][[x]])))
    t_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["t"]][[x]])))
    h_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["h"]][[x]])))
    h_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["h"]][[x]])))
    
    plot(NULL,
         xlim = c(t_min, t_max),
         ylim = c(h_min, h_max),
         xlab = "",
         ylab = "")
    
    for ( i in seq_len(no_of_entries)){
      graphics::lines(multiadm$t[[i]], multiadm$h[[i]])
    }
  }
  
  if (mode == "envelope"){
    no_of_entries = multiadm$no_of_entries
    t_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["t"]][[x]])))
    t_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["t"]][[x]])))
    h_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["h"]][[x]])))
    h_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["h"]][[x]])))

    plot(NULL,
         xlim = c(t_min, t_max),
         ylim = c(h_min, h_max),
         xlab = "",
         ylab = "")
    
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
