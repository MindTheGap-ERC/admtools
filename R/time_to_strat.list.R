time_to_strat.list = function(obj, x, ...){
  #' 
  #' @export
  #' 
  #' @title transform list from time to height domain
  #' 
  #' @description
  #' Lists are useful to keep data closely associated. This function transforms a list that contains observations
  #' associated with a time (recorded in the element with name "t") into a list where
  #' the observations are associated with stratigraphic position.
  #' 
  #' 
  #' @param obj a list with one element named "t", which will be interpreted as time
  #' @param x an _adm_ object
  #' @param ... options passed to _get_height_
  #' 
  #' @seealso [strat_to_time.list()] for the transformation from height to time domain
  #' 
  #' @returns a list with one named element "h" instead of the element "t", containing the stratigraphic positions corresponding to the times inf "t"
  #' 
  #' @examples
  #' # see vignette("admtools") for an example
  #' 
  
  li = obj
  adm = x
  
  if (! "t" %in% names(li)){
    stop("no time information found. Expected element with name \"t\" in list")
  }
  if ("h" %in% names(li)){
    warning("Found element with name \"h\" in list. Height information will be overwritten")
  }
  
  li[["h"]]  = get_height(adm, t = li[["t"]], ...)
  li = li[names(li) != "t" ]
  return(li)
  
}
