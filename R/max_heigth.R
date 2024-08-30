max_height = function(x, ...){
  #' @export
  #' 
  #' @title get highest stratigraphic tie point
  #' 
  #' @param x age-depth model (adm) or sediment accumulation curve (sac)
  #' @param ... other variables, ignored
  #' 
  #' @returns number, stratigraphic position of the highest stratigraphic tie point
  #' 
  #' @seealso [min_height()], [get_total_thickness()]
  #' 
  UseMethod("max_height")
}

max_height.adm = function(x, ...){
  #' @export
  h = get_L_tp.adm(x)
  return(max(h))
}

max_height.sac = function(x, ... ){
  #' @export
  #' 
  h = get_L_tp.sac(x)
  return(max(h))
}