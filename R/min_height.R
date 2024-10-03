min_height = function(x){
  
  #' @export
  #' 
  #' @title get lowest stratigraphic tie point
  #' 
  #' @param x an age-depth model (adm) or sediment accumulation curve (sac)
  #' 
  #' @returns number, stratigraphic position of lowest tie point
  #' 
  #' @seealso [get_total_thickness()], [max_height()]
  #' 
  UseMethod("min_height")
  
}

min_height.adm = function(x){
  
  #' @export
  h = get_L_tp.adm(x)
  return(min(h))
}

min_height.sac = function(x){
  #' @export
  h = get_L_tp.sac(x)
  return(min(h))
}