make_adm_canvas = function(){
  
  #'
  #' @noRd
  #' @keywords internal
  #' 
  #' @title initialize amd plot
  #' 
  #' @description
    #' generates an empty plot for adm plotting
    #' 
  #' 
  #' @returns invisible NULL 
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  
  
  
  plot(NULL,
       xlim = list$t_range,
       ylim = list$h_range,
       xlab = "",
       ylab = "")
}
