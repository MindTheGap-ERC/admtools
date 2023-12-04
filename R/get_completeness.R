get_completeness = function(x){
  
  #' 
  #' @export
  #' 
  #' @aliases get_incompleteness
  #' 
  #' @title Determine stratigraphic (in)completeness
  #'  
  #' @usage
    #' get_completeness(x)
    #' get_incompleteness(x)
  #' 
  #' @param x an adm object
  #' 
  #' @details
    #' Stratigraphic (in)completeness is expressed as a proportion, i.e. a number
    #' between 0 and 1
    #' 
  #' 
  #' @returns Number between 0 and 1, the stratigraphic (in)completeness
  #' 
  #' @examples
    #' my_adm = tp_to_adm(t = 1:4, h = c(1,2,2,4))
    #' get_completeness(my_adm)
    #' get_incompleteness(my_adm)
    #' 
  
UseMethod("get_completeness")
}
