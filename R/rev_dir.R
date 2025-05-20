rev_dir = function(x, ref){
  #' @export
  #' 
  #' @title reverse direction of time/depth axis
  #' 
  #' @param x object to transform - typically a `fossil` or `taxonomy` object
  #' @param ref reference point used for reversal
  #' 
  #' @description
    #' The `FossilSim` package simulates fossils, trees, and taxonomies using age
    #' meaning 0 represents the present and larger numbers indicate older ages
    #' To interact with `admtools`, the direction of time must be reversed
    #' effectively replaces the time component `t` of an object by `ref - t`
    #' 
  #' @examples
    #' \dontrun{
    #'   # for usage example, see
    #'   vignette("FossilSim_integration")
    #' }
    #' 
    #' 
  
  UseMethod("rev_dir")
}

rev_dir.default = function(x, ref){
  #' @export
  .NotYetImplemented()
}

rev_dir.fossils = function(x, ref){
  #' @export
  #' 
  hmin = ref - x$hmin
  hmax = ref - x$hmax
  
  x$hmin = hmin
  x$hmax = hmax
  return(x)
}

rev_dir.taxonomy = function(x, ref){
  #' @export
  
  start1 = ref - x$start
  end1 = ref - x$end
  
  x$start = start1
  x$end = end1
  
  return(x)
}