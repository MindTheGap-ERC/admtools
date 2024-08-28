tp_to_sac = function(t, h, T_unit = NULL, L_unit = NULL){
  #' @export
  #' 
  #' @title define sed. acc. curve
  #' 
  #' @description
    #' defines _sac_ (sediment accumulation curve) object from tie points
    #' 
  #' @param t numeric vector, time coordinates of tie points
  #' @param h numeric vector, height coordinates of tie points
  #' @param T_unit time unit
  #' @param L_unit length unit
  #' 
  #' @returns a _sac_ object reflecting a sediment accumulation curve
  #' 
  #' @seealso [sac_to_adm()] to transform sediment accumulation curves into age-depth models,  [get_T_tp()] and [get_L_tp()] to extract time and height/length tie points
  
  li = list(t = t,
            h = h,
            T_unit = T_unit,
            L_unit = L_unit)
  class(li) = "sac"
  return(li)
}