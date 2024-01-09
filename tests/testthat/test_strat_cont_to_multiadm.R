test_that("constant proxy vals return linear adm", {
  h_min = 0
  h_max = 1
  t_min = 0
  t_max = 1
  no_eval = 100
  t_tp = function() return(c("t1" = t_min, "t2" = t_max))
  h_tp = function() return(c("h1" = h_min, "h2" = h_max))
  strat_cont_gen = function() return(approxfun(x = c(h_min, h_max), y = c(1,1), rule = 2))
  time_cont_gen = function() return(approxfun(x = c(t_min, t_max), y = c(1,1), rule = 2))
  h = seq(h_min, h_max, length.out = no_eval)
  madm = strat_cont_to_multiadm(h_tp, t_tp, strat_cont_gen, time_cont_gen, h)
  expect_equal(unname(madm$h[[1]]), h)
  expect_equal(unname(madm$t[[1]]), seq(t_min, t_max, length.out = no_eval))
  
})
