tp_2_adm = function(t, h, T_unit = NA,L_unit = NA){
  #'
  #' @title Turn tie points into age-depth model
  #' 
  #' @param t tie points in time
  #' @param h tie points in height
  #' @param T_unit Time unit
  #' @param L_unit Length unit
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
