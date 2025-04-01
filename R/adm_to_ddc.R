adm_to_ddc = function(adm1, adm2){
  #' 
  #' @export
  #' 
  #' @title construct depth-depth curve from age-depth models
  #' 
  #' @param adm1 age-depth model 1. An `adm` object 
  #' @param adm2 age-depth model 2. An `adm` object
  #' 
  #' @description
    #' constructs a depth-depth curve from section 1 (described by `adm1`) to section 2 (described by `adm2`)
    #' 
  t1 = get_T_tp(adm1)
  h1 = get_L_tp(adm1)
  t2 = get_T_tp(adm2)
  h2 = get_L_tp(adm2)
  # find joint support of adms
  t_joint = sort(unique(c(t1,t2)))
  t_joint = t_joint[t_joint <= min(c(max(t1), max(t2)))]
  t_joint = t_joint[t_joint >= max(c(min(t1), min(t2)))]
  
  h1_joint = get_height(adm1, t_joint, destructive = FALSE)
  h2_joint = get_height(adm2, t_joint, destructive = FALSE)
  
  ddc = list(h1 = h1_joint,
             h2 = h2_joint,
             L_unit_1 = get_L_unit(adm1),
             L_unit_2 = get_L_unit(adm2),
             sec_1_name = paste0("section of ", deparse(substitute(adm1))),
             sec_2_name = paste0("section of ", deparse(substitute(adm2))))
  class(ddc) = "ddc"
  return(ddc)
  
}