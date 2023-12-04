merge_adm_to_multiadm = function(...){
  
  #' 
  #' @export
  #' 
  #' @title combine multiple adm ojects into multiadm object
  #' 
  #' @param ... adm objects
  #' 
  #' @returns object of class multiadm
  #' 
  
  adm_list = list(...)
  
  multiadm = list("t" = list(),
                  "h" = list(),
                  "destr" = list(),
                  "no_of_entries" = length(adm_list),
                  "T_unit" = NULL,
                  "L_unit" = NULL)
  for (i in seq_along(adm_list)){
    adm = adm_list[[i]]
    multiadm[["t"]][[i]] = adm$t
    multiadm[["h"]][[i]] = adm$h
    multiadm[["destr"]][[i]] = adm$destr

  }

  class(multiadm) = "multiadm"
  return(multiadm)
}
