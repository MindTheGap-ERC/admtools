split_multiadm = function(x){
  
  #'
  #' @export
  #' 
  #' @title split multiadm objects into adm
  #' 
  #' @param x a multiadm object
  #' 
  #' @returns list with objects of class adm
  #'

  adm_list = list()
  for (i in seq_len(x$no_of_entries)){
    adm_list[[i]] = tp_to_adm(t = x[["t"]][[i]],
                             h = x[["h"]][[i]],
                             T_unit = x[["T_unit"]],
                             L_unit = x[["L_unit"]])
  }
  return(adm_list)
  
}
