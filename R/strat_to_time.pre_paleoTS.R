strat_to_time.pre_paleoTS = function(obj, x, ...){
  #' @export
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
  class(li) = c("pre_paleoTS" ,"timelist", "list")
  return(li)
  
}