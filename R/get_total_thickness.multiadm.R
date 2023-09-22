get_total_thickness.multiadm = function(multiadm){
  no_of_entries = length(multiadm$t)
  return(sapply(seq_len(no_of_entries), function(x) diff(range(multiadm$h[[x]]))))
}
