time_to_strat.pre_paleoTS = function(obj, x, ...){
  #' @export
  
  li = obj
  adm = x
  
  if (! "t" %in% names(li)){
    stop("no time information found. Expected element with name \"t\"")
  }
  if ("h" %in% names(li)){
    warning("Found element with name \"h\" in list. Height information will be overwritten")
  }
  
  li[["h"]]  = get_height(adm, t = li[["t"]], ...)
  li = li[names(li) != "t" ]
  class(li) = c("pre_paleoTS" , "stratlist", "list")
  return(li)
}