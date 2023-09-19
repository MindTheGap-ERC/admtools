get_time = function(adm, h){
  time = approx(x = adm$h,
                y = adm$t,
                method = "linear",
                ties = "ordered",
                xout = h)$y
  return(time)
}
