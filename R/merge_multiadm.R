merge_multiadm = function(...){
  
  #'
  #' @export
  #' 
  #' @title merge multiple multiadm objects
  #' 
  #' @param ... adm objects
  #' 
  #' @returns multiadm object
  #' 
  inlist = list(...)
  
  x = inlist[[1]]
  
  if (length(inlist) > 1){
    for (i in 2:length(inlist)){
      next_multiadm = inlist[[i]]
      # split multiadm into adms
      split_multiadm_list = split_multiadm(next_multiadm)
      for (j in length(split_multiadm_list)){
        x = add_adm_to_multiadm(x, split_multiadm_list[[j]])
      }
      
    }
  }
  return(x)
}