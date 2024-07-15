get_total_thickness = function(x){
  
  #' 
  #' 
  #' @export
  #' 
  #' @title get thickness
  #' 
  #' @param x an adm object
  #' 
  #' @returns numeric vector containing total sediment thickness accumulated
  #' 
  #' @seealso [max_height()] and [min_height()] to extract the highest/lowest stratigraphic point
  #' 
  UseMethod("get_total_thickness")
}