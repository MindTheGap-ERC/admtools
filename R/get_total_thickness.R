get_total_thickness = function(x, ...){
  
  #' 
  #' 
  #' @export
  #' 
  #' @title get total thickness
  #' 
  #' @param x an age-depth model (adm/multiadm) or a sediment accumulation curve (sac)
  #' @param ... other options, currently unused
  #' 
  #' @returns numeric, total sediment thickness accumulated
  #' 
  #' @description
    #' for sediment accumulation curves, returns the difference between the highest and lowest point of the curve. For age-depth models, returns the total thickness of sediment accumulated.
    #' 
  #' 
  #' @seealso [max_height()] and [min_height()] to extract the highest/lowest stratigraphic point, [get_total_thicknesses()] to extract thicknesses from depth-depth curves
  #' 
  UseMethod("get_total_thickness")
}

get_total_thickness.multiadm = function(x, ...){
  
  #'
  #' @export
  #' 
  
  multiadm = x
  
  adm_list = split_multiadm(multiadm)
  
  thicknesses  = sapply(adm_list, function(x) get_total_thickness(x))
  return(thicknesses)
  
  
}


get_total_thickness.adm = function(x, ...){
  
  #' 
  #' @export
  #' 
  #' 
  
  adm = x
  return(diff(range(adm$h)))
}

get_total_thickness.sac = function(x, ...){
  #' @export
  #' 
  h = get_L_tp(x)
  return(diff(range(h)))
}

get_total_thickness.ddc = function(x, ...){
  #' @export
  stop("Total thickness of depth-depth curve not defined. Use `get_total_thicknesses` instead.")
}
