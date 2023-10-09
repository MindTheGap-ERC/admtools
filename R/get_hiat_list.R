get_hiat_list = function(x){
  
  #' @export
  #' 
  #' @title extract hiatus info
  #' 
  #' @description
    #' returns a list with hiatus position and timing (start & end)
    #' 
  #' 
  #' @param x an adm object
  #' 
  #' @returns 
    #' a list with one element per hiatus. each element is a named vector with the following entries:
    #' * "height" : stratigraphic position of hiatus
    #' * "start" : time when hiatus begins
    #' *  "end" : time when hiatus ends
  #' 
  #' @seealso 
    #' * [get_hiat_pos()] to determine only stratigraphic position of hiatuses
    #' * [get_hiat_no()] to determine number of hiatuses in an adm
    #' * [get_hiat_duration()] to determine duration of hiatuses
  #' 
  
  UseMethod("get_hiat_list")

  
}