min_height = function(x){
  
  #' @export
  #' 
  #' @title get lowest stratigraphic position in an adm
  #' 
  #' @param x an age-depth model
  #' 
  #' @seealso [get_total_thickness()], [max_height()]
  #' 
  UseMethod("min_height")
  
}

min_height.adm = function(x){
  
  #' @export
  
  return(min(x$h))
}