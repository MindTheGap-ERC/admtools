sac_to_adm = function(x){
  #' @export
  #' 
  #' @title turn sed. acc curve into adm
  #' 
  #' @param x object of class _sac_
  #' 
  #' @returns object of class _adm_
  #' 
  #' @seealso [tp_to_adm()] for the generator of _adm_
  
  h = sapply(seq_along(x$h), function(i) min(x$h[i:length(x$h)]) )
  adm = tp_to_adm(t = x$t,
                  h = h,
                  T_unit = x$T_unit,
                  L_unit = x$L_unit)
  return(adm)
}