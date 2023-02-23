#### age_to_time ####
age=c(65,64)
age_to_time(age)

#### depth_to_height ####

depth = c(200,100)
depth_to_height(depth)

#### order_with_time_increasing_base ####
# standard case
time=c(0,1,2,3)
height = runif(length(time))
order_with_time_increasing_base(time,height)

# reversed order
time = rev(time)
height = runif(length(time))
order_with_time_increasing_base(time,height)

# unordered time
time = c(2,1,3,4)
height = runif(length(time))
order_with_time_increasing_base(time,height)

# duplicates in time throws error
time = c(1,1,2,3)
height = runif(length(time))
order_with_time_increasing_base(time,height)

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
