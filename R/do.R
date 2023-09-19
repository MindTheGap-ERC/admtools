



a = as_adm(t = 1:5, h = c(1,1.5,2,3,4))
plot(a)
plot(a$t,a$h, type = "l")
a$destr

get_height(a, t = 2.5)
get_height(a, t = 3)

get_time(a, h = 2)
get_time(a, 1)
f = is_destructive_fun(a)
f(1.5  )
plot(f(seq(1,5,by = 0.1)))



h = get_height(adm = a, t = seq(0,5, by = 0.1))

t  = get_time(adm = a, h)
plot(h,t)
