#### Tests for Utility Functions ####
rm(list = ls())
.rs.restartR()

source("src/utility_functions.R")


#### age_to_time ####
age <- c(65, 64)
time <- age_to_time(age)
all(age == -time) # true if correct

#### depth_to_height ####
depth <- c(200, 100)
height <- depth_to_height(depth)
all(depth == -height) # true if correct

#### parallel_sorting ####
### Scenario 1: x & y have same no of elements
## standard case
x_in <- c(0, 1, 2, 3)
y_in <- runif(length(x_in))
out <- parallel_sorting(
  x = x_in,
  y = y_in
)
# should return the original inputs
all(out$x == x_in) && all(out$y == y_in)

## reversed x
x_in <- rev(c(0, 1, 2, 3))
y_in <- runif(length(x_in))
out <- parallel_sorting(
  x = x_in,
  y = y_in
)
# both x and y should be reversed
all(x_in == rev(out$x)) && all(y_in == rev(out$y))

## unordered x
x_in <- c(2, 1, 3, 4)
y_in <- runif(length(x_in))
out <- parallel_sorting(
  x = x_in,
  y = y_in
)
# all values shout match the parallel sorted values
xsort <- sort(x_in, index.return = TRUE)
all(x_in[xsort$ix] == out$x) && all(y_in[xsort$ix] == out$y)

## duplicate x values
x_in <- c(2, 1, 1, 4)
y_in <- runif(length(x_in))
out <- parallel_sorting(
  x = x_in,
  y = y_in
)
# should throw error

### Case 2: y has different no of elements (but more than 0)

## standard case
x_in <- c(0, 1, 2, 3)
y_in <- runif(length(x_in) - 1)
out <- parallel_sorting(
  x = x_in,
  y = y_in
)
# should return the original inputs
all(out$x == x_in) && all(out$y == y_in)

## reversed x
x_in <- rev(c(0, 1, 2, 3))
y_in <- runif(length(x_in) - 1)
out <- parallel_sorting(
  x = x_in,
  y = y_in
)
# both x and y should be reversed
all(x_in == rev(out$x)) && all(y_in == rev(out$y))

## unordered x
x_in <- c(2, 1, 3, 4)
y_in <- runif(length(x_in) - 1)
out <- parallel_sorting(
  x = x_in,
  y = y_in
)
# should throw error

## duplicate x values
x_in <- c(2, 1, 1, 4)
y_in <- runif(length(x_in) - 1)
out <- parallel_sorting(
  x = x_in,
  y = y_in
)
# should throw error

#### sed_rate_to_condensation ####
# standard case: condensation is inverse of sed rate
sed_rate = ceiling(100 * runif(10))
condensation = sed_rate_to_condensation(sed_rate)
all (condensation == sed_rate^-1)

sed_rate = ceiling(100 * runif(10))
sed_rate[5]=0
condensation = sed_rate_to_condensation(sed_rate)
# throws error

sed_rate = ceiling(100 * runif(10))
sed_rate[5]=-0.5
condensation = sed_rate_to_condensation(sed_rate)
# throws error

#### accumulation_increments ####
#integration procedure

### case 1: length(x) == length(y), mode: "pl"
x = 0:10
y = seq(0, 3, length.out = length(x))

acc_incr = accumulate_increments(x,y,mode = "pl")

plot(x,acc_incr)

### case 2: length(x) -1 == length(y), mode : pc
x = 0:10
y = seq(0, 3, length.out = length(x) - 1)

acc_incr = accumulate_increments(x,y,mode = "pc")

plot(x,acc_incr)
