get_height = function(x, t, destructive = TRUE, out_dom_val_h = "default", ...){
  
  #' @export
  #' 
  #' @title determine stratigraphic height deposited at specific time
  #' 
  #' @description
  #' Takes an adm object and a vector of times, and returns the stratigraphic
  #' heights deposited at said times
  #' 
  #' 
  #' @usage get_height(adm, t, destructive = TRUE, out_dom_val_h = "default", ...)
  #' 
  #' @param x an _adm_ or _multiadm_ object
  #' @param t vector of times
  #' @param destructive logical - should destructive intervals be considered? See Details
  #' @param out_dom_val_h "strat_limits", "default", or a vector with one or two entries. What value is assigned to times that are not covered by the age-depth model? 
  #' @param ... parameters handed over to is_destructive
  #' 
  #' @details
  #' if destructive is true, NA is returned for times that coincide with
  #' destructive intervals. This is achieved by calling _is_destructive_ with
  #' arguments passed by _..._. 
  #' 
  #' _out_dom_val_ specified the return value for times that are not covered by the 
  #' age-depth model. For "default", NA is returned. For "strat_limits", the lowest
  #' resp. highest stratigraphic position is returned. For a vector of length one, this value is assigned 
  #' to both sides. For a vector or length 2 or more, the first and second entries are assigned on the left (resp. right) side
  #' 
  #' 
  #' 
  #' @returns a vector with same length as t, containing the strat heights deposited
  #' 
  
  UseMethod("get_height")
}
