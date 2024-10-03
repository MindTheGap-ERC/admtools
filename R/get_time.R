get_time = function(x, h, hiat_mode = "start", bdry_pts_hiat = "destructive", out_dom_val_t = "default"){
  #' @export
  #' 
  #' 
  #' @title Determine times based on age-depth model
  #' 
  #' @description
  #' Takes an age-depth model and vector of stratigraphic positions to determine
  #' the corresponding time of formation
  #' 
  #' 
  #' @usage get_time(x, h, hiat_mode = "start", 
  #' bdry_pts_hiat = "destructive", out_dom_val_t = "default")
  #' 
  #' @param x an _adm_ or _multiadm_ object
  #' @param h vector of stratigraphic positions
  #' @param hiat_mode "start", "end", or "destroy". If a stratigraphic position coincides with a hiatus, what should be returned?
  #' @param bdry_pts_hiat "consistent" or "destructive". How are hiatuses at the start/end of the adm treated?
  #' @param out_dom_val_t :"default", "time_limits", or a numeric value. What value is returned for heights not covered by the age-depth model?
  #' 
  #' @returns numeric vector. Times of deposition of the provided heights in h
  #' 
  #' @details
  #'  If a stratigraphic position
  #' coincides with a hiatus, should the start time or the end time of the hiatus be returned? 
  #' Using "destroy" returns NA
  #'If the adm starts/ends with a hiatus, should
  #' the time returned be consistent with _hiat_mode_, or should it be NA?
  
    
  UseMethod("get_time")
}
