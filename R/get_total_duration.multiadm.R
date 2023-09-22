get_total_duration.multiadm = function(multiadm){
  no_of_entries = length(multiadm$t)
  return(sapply(seq_len(no_of_entries), function(x) diff(range(multiadm$t[[x]]))))
}
