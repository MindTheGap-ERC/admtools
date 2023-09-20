get_time = function(adm, h, mode = "oldest"){
  if(mode == "oldest"){
    time = approx(x = adm$h,
                  y = adm$t,
                  method = "linear",
                  ties = list("ordered",max),
                  xout = h)$y
    return(time)
  }
  if (mode == "youngest"){
    time = approx(x = adm$h,
                  y = adm$t,
                  method = "linear",
                  ties = list("ordered",min),
                  xout = h)$y
    return(time)
  }
  stop("Did not find mode")
  
}
