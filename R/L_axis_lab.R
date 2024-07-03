L_axis_lab = function(label = "Height", unit = TRUE, sep = " ", brac = c("[", "]"), line = 2, outer = FALSE, at = NA,
                      adj = NA, padj = NA, cex = NA, col = NA, font = NA, ...){
  
  #'
  #' @export
  #' 
  #' @title plot height axis label
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
  #' @returns invisible NULL
  #' 
  #' @seealso [plot.adm()] for plotting of adms
  
  list = get("adm_plot_info", envir = .adm_plot_env)
  
  L_unit = list$L_unit
  
  if (unit == FALSE){
    L_lab = NULL
  } else if (unit == TRUE){
    if (!is.null(L_unit)){
      L_lab = paste0(sep, brac[1], L_unit, brac[2])
    } else {
      L_lab = NULL
    }
  } else {
    L_lab = paste0(sep, brac[1], unit, brac[2])
  }
  
  graphics::mtext(text = paste(label, L_lab, sep = ""),
                  side = 2,
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
