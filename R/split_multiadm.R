split_multiadm = function(multiadm){
  adm_list = list()
  for (i in seq_len(multiadm$no_of_entries)){
    adm_list[[i]] = tp_2_adm(t = multiadm[["t"]][[i]],
                             h = multiadm[["h"]][[i]])
  }
}
