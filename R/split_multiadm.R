split_multiadm = function(multiadm){
  
  #'
  #' @export
  #' 
  #' @title split multiadm objects into adm
  #' 
  #' @param multiadm a multiadm object
  #' 
  #' @returns list with objects of class adm
  #'
  adm_list = list()
  for (i in seq_len(multiadm$no_of_entries)){
    adm_list[[i]] = tp_2_adm(t = multiadm[["t"]][[i]],
                             h = multiadm[["h"]][[i]])
  }
  return(adm_list)
  
}
