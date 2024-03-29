get_hiat_pos = function(x){
  
  #' 
  #' @export
  #' 
  #' @title get hiatus positions
  #' 
  #' @description
    #' Determines stratigraphic position of hiatuses
  #'
  #' @param x an adm object
  #' 
  #' @returns numeric vector with stratigraphic positions of hiatuses
  #' 
  #' @seealso 
    #' * [get_hiat_list()] to get hiatus positions and durations
    #' * [get_hiat_no()] to determine number of hiatuses
    #' * [get_hiat_duration()] to determine duration of hiatuses
  #' 
  #' 
  #' @examples
    #' my_adm = tp_to_adm(t = 1:4, h = c(1,2,2,3)) # one hiatus at height 2
    #' get_hiat_pos(my_adm)
  #' 
  
  UseMethod("get_hiat_pos")
}
