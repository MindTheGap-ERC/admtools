tp_2_adm = function(t, h, T_unit = NULL, L_unit = NULL){
  #'
  #' @title Turn tie points into age-depth model
  #' 
  #' @description
    #' Takes vectors of tie points and turns them into an age-depth model object (adm)
    #' 
  #' 
  #' 
  #' @param t tie points in time
  #' @param h tie points in height
  #' @param T_unit time unit
  #' @param L_unit length unit
  #' 
  #' @details
    #' by default, intervals with no sediment accumulation are marked as destructive
    #' _tp_2_adm_ does not check whether the inputs define a valid age-depth model. For this, use
    #' _is_adm_
    #' 
  #' 
  #' @returns an adm object
  #'
  #'
  #' @examples
    #' 
    #'  my_adm = tp_2_adm(t = 1:4, h = c(1,2,2,3), T_unit = "kyr", L_unit = "m")
  #' 
  #' 
  #' @export
  
  destructive = duplicated(h)[2:length(h)]
  adm = list(t = t,
             h = h,
             destr = destructive,
             T_unit = T_unit,
             L_unit = L_unit)
 class(adm) = "adm"
  return(adm)
}
