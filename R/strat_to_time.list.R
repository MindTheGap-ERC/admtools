strat_to_time.list = function(obj, x, ...){
  
  #' 
  #' @export
  #' 
  #' @title transform list from height to time domain
  #' 
  #' @description
    #' Lists are useful to keep data closely associated. This function transforms a list that contains observations
    #' associated with a stratigraphic position (recorded in the element with name "h") into a list where
    #' the observations are associated with time.
    #' 
  #' 
  #' @param obj a list with one element named "h", which will be interpreted as stratigraphic positions
  #' @param x an _adm_ object
  #' @param ... options passed to `get_time`
  #' 
  #' @seealso [time_to_strat.list()] for the transformation from time to height domain, [get_time()] for the underlying procedure, [time_to_strat()] for the higher level function
  #' 
  #' @returns a `timelist` (inherits from `list`). A list with one named element "t" instead of the element "h". This element contains the times of the stratigraphic positions in "h".
  #' 
  #' @examples
    #' # see vignette("admtools") for an example
    #' 
  
  li = obj
  adm = x
  
  if (! "h" %in% names(li)){
    stop("no stratigraphic information found. Expected element with name \"h\" in list")
  }
  if ("t" %in% names(li)){
    warning("Found element with name \"t\" in list. Temporal information will be overwritten")
  }
  
  li[["t"]]  = get_time(adm, h = li[["h"]], ...)
  li = li[names(li) != "h" ]
  class(li) = c("timelist", "list")
  return(li)
}