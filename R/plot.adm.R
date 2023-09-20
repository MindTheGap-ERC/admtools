plot.adm = function(adm,...){
  add_T_label = TRUE
  add_L_label = TRUE
  if (add_T_label){
    T_label = "Time"
    if (!is.na(adm$T_unit)){
      T_label = paste0(T_label, " [",adm$T_unit,"]", sep ="")
    }
  }
  if (add_L_label){
    L_label = "Height"
    if (!is.na(adm$L_unit)){
      L_label = paste0(L_label, " [",adm$L_unit,"]", sep ="")
    }
  }
  plot(x = adm$t,
       y = adm$h,
       type = "l",
       xlab = T_label,
       ylab = L_label,
       ...)
}
