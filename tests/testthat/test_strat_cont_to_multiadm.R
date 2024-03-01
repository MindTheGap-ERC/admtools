test_that("constant proxy vals return linear adm between tps", {
  h_min = 2
  h_max = 3
  t_min = -3
  t_max = -2
  no_eval = 100
  t_tp = function() return(c( t_min,  t_max))
  h_tp = function() return(c( h_min,  h_max))
  strat_cont_gen = function() return(approxfun(x = c(h_min, h_max), y = c(1,1), rule = 2))
  time_cont_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min + 0.1, h_max - 0.1, length.out = no_eval)
  madm = strat_cont_to_multiadm(h_tp, t_tp, strat_cont_gen, time_cont_gen, h, no_of_rep = 1)
  expect_equal(madm$h[[1]], h)
  expect_equal(madm$t[[1]], seq(t_min + 0.1, t_max - 0.1, length.out = no_eval))
})

test_that("constant proxy vals return linear adm", {
  h_min = 2
  h_max = 3
  t_min = -3
  t_max = -2
  no_eval = 100
  t_tp = function() return(c( t_min,  t_max))
  h_tp = function() return(c( h_min,  h_max))
  strat_cont_gen = function() return(approxfun(x = c(h_min, h_max), y = c(1,1), rule = 2))
  time_cont_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min, h_max , length.out = no_eval)
  madm = strat_cont_to_multiadm(h_tp, t_tp, strat_cont_gen, time_cont_gen, h, no_of_rep = 1)
  expect_equal(madm$h[[1]], h)
  expect_equal(madm$t[[1]], seq(t_min, t_max, length.out = no_eval))
})

test_that("estimation outside of tps works", {
  h_min = 2
  h_max = 3
  t_min = -3
  t_max = -2
  no_eval = 100
  t_tp = function() return(c( t_min,  t_max))
  h_tp = function() return(c( h_min,  h_max))
  strat_cont_gen = function() return(approxfun(x = c(h_min, h_max), y = c(1,1), rule = 2))
  time_cont_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min - 1, h_max + 1 , length.out = no_eval)
  madm = strat_cont_to_multiadm(h_tp, t_tp, strat_cont_gen, time_cont_gen, h, no_of_rep = 1)
  expect_equal(madm$h[[1]], h)
  expect_equal(madm$t[[1]], seq(t_min-1, t_max + 1, length.out = no_eval))
})



test_that("multiple tie points work",{
  t_1 = 0
  t_2 = 1
  t_3 = 2
  h_1 = 0
  h_2 = 1
  h_3 = 3
  t_tp = function() return(c(t_1,t_2, t_3))
  h_tp = function() return(c(h_1,h_2,h_3))
  strat_cont_gen = function() return(approxfun(x = c(h_1, h_3), y = c(1,1), rule = 2))
  time_cont_gen = function() return(approxfun(x = c(t_1, t_3), y = c(1,1), rule = 2))
  h = seq(h_1,h_3, by = 0.1)
  madm = strat_cont_to_multiadm(h_tp, t_tp, strat_cont_gen, time_cont_gen, h, no_of_rep = 1)
  expect_equal(madm$h[[1]], h)
  expect_equal(madm$t[[1]], unique(c(seq(t_1, t_2, by = 0.1), seq(t_2, t_3, by = 0.05))))
})

test_that("errors in tie point encoding are caught", {
  # prelims
  t_min = 0
  t_max = 1
  h_min = 0
  h_max = 1
  no_eval = 100
  # disorder in time tp
  t_tp = function() return(c( t_max,  t_min))
  h_tp = function() return(c( h_min,  h_max))
  strat_cont_gen = function() return(approxfun(x = c(h_min, h_max), y = c(1,1), rule = 2))
  time_cont_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min, h_max, length.out = no_eval)
  expect_error(strat_cont_to_multiadm(h_tp, t_tp, strat_cont__gen, time_cont_gen, h, no_of_rep = 1))
  # disorder in height tp
  t_tp = function() return(c( t_min,  t_max))
  h_tp = function() return(c( h_max,  h_min))
  expect_error(strat_cont_to_multiadm(h_tp, t_tp, strat_cont__gen, time_cont_gen, h, no_of_rep = 1))
  #different no of tie points
  t_tp = function() return(1:3)
  h_tp = function() return(c( h_min,  h_max))
  expect_error(strat_cont_to_multiadm(h_tp, t_tp, strat_cont__gen, time_cont_gen, h, no_of_rep = 1))
  
})

test_that("unbounded intervals with finite tracer volumes are caught", {
h_1 = 0
t_1 = 0
no_of_rep = 1
t_tp = function() return(t_1)
h_tp = function() return(h_1)
strat_cont_gen = function() return(function(x) pmin(rep(1,length(x)),exp(-x)))
time_cont_gen = function() return(function(x) pmin(rep(1,length(x)),exp(-x)))
h = seq(0,1,by = 0.1)
madm = strat_cont_to_multiadm(h_tp, t_tp, strat_cont_gen, time_cont_gen, h, no_of_rep = no_of_rep)
expect_equal(madm$h[[1]], h)
expect_equal(madm$t[[no_of_rep]], seq(0,1,by = 0.1), tolerance = 0.001)
})
