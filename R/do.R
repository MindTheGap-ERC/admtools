

plot.adm = function(adm){
  plot(adm$t, adm$h, type = "l")
}

plot(adm)


get_time = function(adm,tt){
  UseMethod("get_time")
}

get_time = function(adm,tt){
  return(approx(adm$t,adm$h, xout = tt))
}

get_time(adm, 3
         )



a = as_adm(t = 1:5, h = c(1,1,2,3,4))
plot(a)
a$destr



f = is_destructive_fun(a)
f(1.5  )
plot(f(seq(1,5,by = 0.1)))



get_height(adm = adm, t = seq(0,5, by = 0.1))
