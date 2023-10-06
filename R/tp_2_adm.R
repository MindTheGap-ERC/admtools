tp_2_adm = function(t, h){
  #'
  #' @title Turn tie points into age-depth model
  #' 
  #' @description
    #' Takes vectors of tie points and turns them into an age-depth mode (adm)
    #' 
  #' 
  #' @usage tp_2_adm(t,h)
  #' 
  #' @param t tie points in time
  #' @param h tie points in height
  #' 
  #' @details
    #' by default, intervals with no sediment accumulation are marked as destructive
    #' _tp_2_adm_ does not check whether the inputs define a valid age-depth model. For this, use
    #' _is_adm_
    #' 
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
