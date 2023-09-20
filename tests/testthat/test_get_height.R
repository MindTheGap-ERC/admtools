test_that("time interpolation at tie points returns tie points", {
  t = 1:3
  h = 2:4
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_height(adm = adm, t = t), h)
})

