test_that("constant sed rate gives correct results for 2 tp",{
  t_min = 0
  t_max = 1
  h_min = 0
  h_max = 1
  no_eval = 100
  t_tp = function() return(c("t1" = t_min, "t2" = t_max))
  h_tp = function() return(c("h1" = h_min, "h2" = h_max))
  sed_rate_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min, h_max, length.out = no_eval)
  madm  = sedrate_to_multiadm(h_tp, t_tp, sed_rate_gen, h, no_of_rep = 1)
  expect_equal(madm$h[[1]], h)
  expect_equal(madm$t[[1]], seq(t_min, t_max, length.out = no_eval))
  
})

test_that("errors in tie point encoding are caught", {
  # prelims
  t_min = 0
  t_max = 1
  h_min = 0
  h_max = 1
  no_eval = 100
  # disorder in time tp
  t_tp = function() return(c("t1" = t_max, "t2" = t_min))
  h_tp = function() return(c("h1" = h_min, "h2" = h_max))
  sed_rate_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min, h_max, length.out = no_eval)
  expect_error(sedrate_to_multiadm(h_tp, t_tp, sed_rate_gen, h, no_of_rep = 1))
  # disorder in height tp
  t_tp = function() return(c("t1" = t_min, "t2" = t_max))
  h_tp = function() return(c("h1" = h_max, "h2" = h_min))
  sed_rate_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min, h_max, length.out = no_eval)
  expect_error(sedrate_to_multiadm(h_tp, t_tp, sed_rate_gen, h, no_of_rep = 1))
  #different no of tie points
  t_tp = function() return(1:3)
  h_tp = function() return(c("h1" = h_min, "h2" = h_max))
  sed_rate_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min, h_max, length.out = no_eval)
  expect_error(sedrate_to_multiadm(h_tp, t_tp, sed_rate_gen, h, no_of_rep = 1))
  
})
