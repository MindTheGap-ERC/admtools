plot_condensation = function(x, h = "default", mode = "rcll", ...){
  #' @export
  #' 
  #' @title plot condensation in height
  #' 
  #' @description
    #' plots condensation (time per stratigraphic increment) throughout the section
    #' 
  #' 
  #' @param x an adm object
  #' @param h "default" or a numeric vector of height where the sed rate is evaluated
  #' @param mode string, handed over to _sed_rate_t_, see ?sed_rate_t for details
  #' @param ... parameters passed to _get_time_, see ?get_time for details
  #' 
  #' @returns invisible null
  #' 

  if ("default" %in% h){
    h = x$h
  }
  val = condensation.adm(x,h,mode,...)
  
  plot(x = val,
       y = h,
       xlab = "Condensation",
       ylab = "Height",
       type = "l")
}