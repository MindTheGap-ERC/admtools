test_that("height interpolation at tie points returns tie points", {
  t = 1:3
  h = 2:4
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_time(adm = adm, h = h), t)
})

test_that("youngest and oldest time at hiatuses are returned correctly", {
  # hiatus internal
  t = 1:4
  h = c(1,2,2,4)
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_time(adm = adm, h = 2, mode = "oldest"), 3)
  expect_equal(get_time(adm = adm, h = 2, mode = "youngest"), 2)
  
  # start with hiatus
  adm = tp_2_adm(t = 1:3, h = c(2,2,3))
  expect_equal(get_time(adm, 2, mode = "oldest"), 2)
  expect_equal(get_time(adm, 2, mode = "youngest"), 1)
  
  #end with hiatus
  adm = tp_2_adm(t = 1:3, h = c(2,3,3))
  expect_equal(get_time(adm, 3, mode = "oldest"), 3)
  expect_equal(get_time(adm, 3, mode = "youngest"), 2)
})




