test_that("returns true for correct input", {
  sac = tp_to_sac(t = c(1,2), h = c(2,3), L_unit = "m", T_unit = "Myr")
  expect_no_condition(sac)
})
