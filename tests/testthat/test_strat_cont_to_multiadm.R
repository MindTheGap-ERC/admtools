test_that("constant proxy vals return linear adm", {
  h_min = 0
  h_max = 1
  t_min = 0
  t_max = 1
  no_eval = 100
  t_tp = function() return(c( t_min,  t_max))
  h_tp = function() return(c( h_min,  h_max))
  strat_cont_gen = function() return(approxfun(x = c(h_min, h_max), y = c(1,1), rule = 2))
  time_cont_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min, h_max, length.out = no_eval)
  madm = strat_cont_to_multiadm(h_tp, t_tp, strat_cont_gen, time_cont_gen, h, no_of_rep = 1)
  expect_equal(unname(madm$h[[1]]), h)
  expect_equal(unname(madm$t[[1]]), seq(t_min, t_max, length.out = no_eval))
  
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
  strat_cont_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
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
