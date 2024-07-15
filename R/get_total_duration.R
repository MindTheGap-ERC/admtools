get_total_duration = function(x){
  
  #' @export
  #' 
  #' @title Total duration covered 
  #' 
  #' @param x an adm object
  #' 
  #' @returns numeric vector, total duration covered by the age-depth models
  #' 
  #' @seealso [min_time()] and [max_time()] to extract the first/last tie point in time
  #' 
  UseMethod("get_total_duration")
}
