get_hiat_duration = function(x){
  
  #' @export
  #' 
  #' @title extract hiatus duration
  #' 
  #' @description
  #' returns a vector of hiatus durations       
  #' 
  #' 
  #' @param x an adm object
  #' 
  #' @returns 
  #' a vector with one element per hiatus: the duration of the hiatus
  #' 
  #' @seealso 
  #' * [get_hiat_pos()] to determine only stratigraphic position of hiatuses
  #' * [get_hiat_no()] to determine number of hiatuses in an adm
  #' * [get_hiat_list()] to get hiatus position, stat & end time
  #' 
  
  UseMethod("get_hiat_duration")
  
  
}