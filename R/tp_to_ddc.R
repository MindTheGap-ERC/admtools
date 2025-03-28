tp_to_ddc = function(h1, h2, L_unit_1 = NULL, L_unit_2 = NULL, sec_1 = "", sec_2 = ""){
  #' @export
  #' 
  #' @title construct depth-depth curve from coeval heights
  #' 
  #' @param h1 height tie points in section 1
  #' @param h2 height tie points in section 2
  #' @param L_unit_1 Length unit in section 1
  #' @param L_unit_2 Length unit in section 2
  #' @param sec_1 name of section 1
  #' @param sec_2 name of section 2
  #' 
  #' @description
    #' constructs a depth-depth curve (`ddc` object) from a vector of coeval heights specified by `h1` and `h2`
    #' 
  #' 
  ddc = list(h1 = h1,
             h2 = h2,
             L_unit_1 = L_unit_1,
             L_unit_2 = L_unit_2,
             sec_1_name = sec_1,
             sec_2_name = sec_2)
  class(ddc) = "ddc"
  return(ddc)
}