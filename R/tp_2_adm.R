tp_2_adm = function(t, h){
  #'
  #' @title Turn tie points into age-depth model
  #' 
  #' @param t tie points in time
  #' @param h tie points in height
  #' 
  #' @returns an adm object
  #'
  
  destructive = duplicated(h)[2:length(h)]
  adm = list(t = t,
             h = h,
             destr = destructive)
 class(adm) = "adm"
  return(adm)
}
