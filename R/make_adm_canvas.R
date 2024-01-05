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
  
  x = list$adm
  
  plot(NULL,
       xlim = range(x$t),
       ylim = range(x$h),
       xlab = "",
       ylab = "")
}
