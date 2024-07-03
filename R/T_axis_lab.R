T_axis_lab = function(label = "Time", unit = TRUE, sep = " ", brac = c("[", "]"), line = 2, outer = FALSE, at = NA,
                  adj = NA, padj = NA, cex = NA, col = NA, font = NA, ...){
  
  #'
  #' @export
  #' 
  #' @title plot time axis label
  #' 
  #' @param label Axis label
  #' @param unit Logical or character, should unit be plotted
  #' @param sep separator between label and unit
  #' @param brac brackets surrounding unit
  #' @param line parameter passed to _mtext_, see ?mtext for details
  #' @param outer parameter passed to _mtext_, see ?mtext for details
  #' @param at parameter passed to _mtext_, see ?mtext for details
  #' @param adj parameter passed to _mtext_, see ?mtext for details
  #' @param padj parameter passed to _mtext_, see ?mtext for details
  #' @param cex parameter passed to _mtext_, see ?mtext for details
  #' @param col parameter passed to _mtext_, see ?mtext for details
  #' @param font parameter passed to _mtext_, see ?mtext for details
  #' @param ... further graphical parameters passed to _mtext_, see ?mtext for details
  #' 
  #' @seealso [plot.adm()] for plotting of adms
  #' 
  #' @returns invisible NULL
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  
  T_unit = list$T_unit
  
  if (unit == FALSE){
    T_lab = NULL
  } else if (unit == TRUE){
    if (!is.null(T_unit)){
      T_lab = paste0(sep, brac[1], T_unit, brac[2])
    } else {
      T_lab = NULL
    }
  } else {
    T_lab = paste0(sep, brac[1], unit, brac[2])
  }
  
  graphics::mtext(text = paste(label, T_lab, sep = ""),
        side = 1,
        line = line,
        outer = outer,
        at = at,
        adj = adj,
        padj = padj,
        cex = cex,
        col = col,
        font = font,
        ...)
  
  return(invisible())
}
