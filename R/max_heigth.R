max_height = function(x){
  #' @export
  #' 
  #' @title get highest stratigraphic position in an adm
  #' 
  #' @param x an age-depth model
  #' 
  #' @returns a scalar
  #' 
  #' @seealso [min_height()], [get_total_thickness()]
  #' 
  UseMethod("max_height")
}

max_height.adm = function(x){
  #' @export
  
  return(max(x$h))
}