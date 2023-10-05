plot.multiadm = function(multiadm,...){
  
  #' @export
  #' 
  #' 
  no_of_entries = multiadm$no_of_entries
  t_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["t"]][[x]])))
  t_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["t"]][[x]])))
  h_min = min(sapply(seq_len(no_of_entries), function(x) min(multiadm[["h"]][[x]])))
  h_max = max(sapply(seq_len(no_of_entries), function(x) max(multiadm[["h"]][[x]])))
  
  plot(NULL,
       xlim = c(t_min, t_max),
       ylim = c(h_min, h_max),
       xlab = "Time",
       ylab = "Height")
  
  for ( i in seq_len(no_of_entries)){
    graphics::lines(multiadm$t[[i]], multiadm$h[[i]])
  }
  
}
