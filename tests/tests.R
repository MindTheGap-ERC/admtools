

#### time_height_tie_points_to_adm ####
time=runif(4)
height = runif(length(time))
time_height_tie_points_to_adm(time,height)

#### time_depth_tie_points_to_adm ####
time=1:4
depth = runif(length(time))
time_depth_tie_points_to_adm(time,height)

#### age_height_tie_points_to_adm ####
age = seq(66,69,length.out = 4)
height = runif(length(age))

age_height_tie_points_to_adm(age,height)

#### age_depth_tie_points_to_adm ####
age = seq(66,69,length.out = 4)
depth = runif(length(age))

age_depth_tie_points_to_adm(age,depth)
