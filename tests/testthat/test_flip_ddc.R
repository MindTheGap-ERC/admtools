test_that("flipping twice returns the original depth-depth curve",{
  ddc = tp_to_ddc(h1 = 1:3, h2 = 2:4, L_unit_1 = "m", L_unit_2 = "d")
  expect_equal(ddc, flip_ddc(flip_ddc(ddc)))
})
