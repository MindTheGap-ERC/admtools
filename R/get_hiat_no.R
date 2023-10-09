get_hiat_no = function(x){
  
  #'
  #' @export
  #'
  #' @title get no. of hiatuses
  #' 
  #' @description
    #' Determines the number of hiatuses in an age-depth model
  #'
  #' @usage get_hiat_no(x)
  #'
  #' @param x an adm object
  #' 
  #' @returns An integer, no. of hiatuses in the age-depth model
  #' 
  #' @seealso 
    #' * [get_hiat_pos()] to determine stratigraphic positions of hiatuses
    #' * [get_hiat_list()] to determine position and timing of hiatuses
  #'
  #' @examples
    #' my_adm = tp_2_adm(t = 1:4, h = c(1,2,2,3)) # one hiatus
    #' get_hiat_no(my_adm)
    #' 
  #'
  #'
  UseMethod("get_hiat_no")
}