tp_to_adm = function(t, h, T_unit = NULL, L_unit = NULL){
  #'
  #' @export
  #' 
  #' @title Construct age-depth model from tie points
  #' 
  #' @description
    #' Turns tie points into an `adm` object that represents an age-depth model
    #' 
  #' 
  #' 
  #' @param t Vector, tie points in time
  #' @param h Vector, tie points in height
  #' @param T_unit character, time unit
  #' @param L_unit character, length unit
  #' 
  #' @details
    #' by default, intervals with no sediment accumulation are marked as destructive.
    #' `tp_to_adm` does not check whether the inputs define a valid age-depth model. For this, use
    #' `is_adm`
    #' 
  #' 
  #' @returns object of class `adm`
  #' 
  #' @seealso [is_adm()] to check validity of `adm` objects, [get_T_tp()] and [get_L_tp()] to extract time and height/length tie points
  #'
  #'
  #' @examples
    #' 
    #' my_adm = tp_to_adm(t = 1:4, h = c(1,2,2,3), T_unit = "kyr", L_unit = "m")
    #' plot(my_adm)
    #' # see vignette("admtools") for other examples
    #' 
    #'  
  #' 
  
  destructive = duplicated(h)[2:length(h)]
  adm = list(t = t,
             h = h,
             destr = destructive,
             T_unit = T_unit,
             L_unit = L_unit)
 class(adm) = "adm"
 return(adm)
}
