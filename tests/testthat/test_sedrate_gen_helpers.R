## sedrate_from_matrix is a higher order function. The code below can be used to interactively debug it


# ex=cycles(freqs=c(1/405.6795,1/130.719,1/123.839,1/98.86307,1/94.87666,1/23.62069, 
#                   1/22.31868,1/19.06768,1/18.91979),end=4000,dt=5)
# 
# # convert to meters with a linearly increasing sedimentation rate from 0.01 m/kyr to 0.03 m/kyr
# ex=sedRamp(ex,srstart=0.01,srend=0.03)
# 
# # interpolate to median sampling interval
# ex=linterp(ex)
# 
# # evaluate precession & eccentricity power, and precession modulations
# res=eTimeOpt(ex,win=20,step=1,fit=1,output=1)
# 
# aa = get_data_from_eTimeOpt(res, index = 3)
# 
# f = sed_rate_from_matrix(aa$heights, aa$sed_rate, aa$results, rate = 0.1, mode = "poisson")
# plot(aa$heights, f()(aa$heights), type = "l")
# 
# 
# height = aa$heights
# sedrate = aa$sed_rate
# matrix = aa$results
# rate = 1
# i = 1
# transform = identity
