test_that("height interpolation at tie points returns tie points", {
  t = 1:3
  h = 2:4
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_time(adm = adm, h = h), t)
})

test_that("Assignment of values outside the domain is correct", {
  t = 1:3
  h = 2:4
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_time(adm = adm, h = c(0,5), outside_domain = 5), c(5,5))
  expect_true(is.na(get_time(adm = adm, h = 5, outside_domain = "default")))
  expect_true(is.na(get_time(adm = adm, h = 5, outside_domain = "default")))
  expect_equal(get_time(adm = adm, h = c(0), outside_domain = "time_limits"), 1)
  expect_equal(get_time(adm = adm, h = 5, outside_domain = "time_limits"), 3)
})


test_that("start and end of hiatuses are returned correctly", {
  # hiatus internal
  t = 1:4
  h = c(1,2,2,4)
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_time(adm = adm, h = 2, hiat_mode = "end", bdry_hiat = "consistent"), 3)
  expect_equal(get_time(adm = adm, h = 2, hiat_mode = "start", bdry_hiat = "consistent"), 2)
  expect_true(is.na(get_time(adm = adm, h = 2, hiat_mode = "destroy", bdry_hiat = "consistent")))
  
  
  # adm starts with hiatus
  adm = tp_2_adm(t = 1:3, h = c(2,2,3))
  expect_equal(get_time(adm, 2, hiat_mode = "end", bdry_hiat = "consistent"), 2)
  expect_equal(get_time(adm, 2, hiat_mode = "start", bdry_hiat = "consistent"), 1)
  expect_true(is.na(get_time(adm = adm, h = 2, hiat_mode = "destroy", bdry_hiat = "consistent")))
  
  #adm ends with hiatus
  adm = tp_2_adm(t = 1:3, h = c(2,3,3))
  expect_equal(get_time(adm, 3, hiat_mode = "end", bdry_hiat = "consistent"), 3)
  expect_equal(get_time(adm, 3, hiat_mode = "start", bdry_hiat = "consistent"), 2)
  expect_true(is.na(get_time(adm = adm, h = 3, hiat_mode = "destroy", bdry_hiat = "consistent")))
})

test_that("Hiatuses at start/end of adm are treated correctly", {
  adm = tp_2_adm(t = 1:3, h = c(2,2,3))
  expect_equal(get_time(adm, 2, hiat_mode = "start", bdry_hiat = "consistent"), 1)
  expect_true(is.na(get_time(adm, 2, hiat_mode = "start", bdry_hiat = "destructive")))
  
  adm = tp_2_adm(t = 1:3, h = c(2,3,3))
  expect_equal(get_time(adm, 3, hiat_mode = "end", bdry_hiat = "consistent"), 3)
  expect_true(is.na(get_time(adm, 3, hiat_mode = "end", bdry_hiat = "destructive")))
})



