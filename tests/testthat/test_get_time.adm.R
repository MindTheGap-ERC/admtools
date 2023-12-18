test_that("height interpolation at tie points returns tie points", {
  t = 1:3
  h = 2:4
  adm = tp_to_adm(t = t, h = h)
  expect_equal(get_time(adm, h = h), t)
})

test_that("Assignment of values outside the domain is correct", {
  t = 1:3
  h = 2:4
  adm = tp_to_adm(t = t, h = h)
  expect_equal(get_time(adm, h = c(0,5), out_dom_val_t = 5), c(5,5))
  expect_equal(get_time(adm, h = c(0,5), out_dom_val_t = c(-100, 200)), c(-100, 200))
  expect_true(is.na(get_time(adm, h = 5, out_dom_val_t = "default")))
  expect_true(is.na(get_time(adm, h = 5, out_dom_val_t = "default")))
  expect_equal(get_time(adm, h = c(0), out_dom_val_t = "time_limits"), 1)
  expect_equal(get_time(adm, h = 5, out_dom_val_t = "time_limits"), 3)
})


test_that("start and end of hiatuses are returned correctly", {
  # hiatus internal
  t = 1:4
  h = c(1,2,2,4)
  adm = tp_to_adm(t = t, h = h)
  expect_equal(get_time(adm, h = 2, hiat_mode = "end", bdry_pts_hiat = "consistent"), 3)
  expect_equal(get_time(adm, h = 2, hiat_mode = "start", bdry_pts_hiat = "consistent"), 2)
  expect_true(is.na(get_time(adm, h = 2, hiat_mode = "destroy", bdry_pts_hiat = "consistent")))
  
  
  # adm starts with hiatus
  adm = tp_to_adm(t = 1:3, h = c(2,2,3))
  expect_equal(get_time(adm, 2, hiat_mode = "end", bdry_pts_hiat = "consistent"), 2)
  expect_equal(get_time(adm, 2, hiat_mode = "start", bdry_pts_hiat = "consistent"), 1)
  expect_true(is.na(get_time(adm, h = 2, hiat_mode = "destroy", bdry_pts_hiat = "consistent")))
  
  #adm ends with hiatus
  adm = tp_to_adm(t = 1:3, h = c(2,3,3))
  expect_equal(get_time(adm, 3, hiat_mode = "end", bdry_pts_hiat = "consistent"), 3)
  expect_equal(get_time(adm, 3, hiat_mode = "start", bdry_pts_hiat = "consistent"), 2)
  expect_true(is.na(get_time(adm, h = 3, hiat_mode = "destroy", bdry_pts_hiat = "consistent")))
})

test_that("Hiatuses at start/end of adm are treated correctly", {
  adm = tp_to_adm(t = 1:3, h = c(2,2,3))
  expect_equal(get_time(adm, 2, hiat_mode = "start", bdry_pts_hiat = "consistent"), 1)
  expect_true(is.na(get_time(adm, 2, hiat_mode = "start", bdry_pts_hiat = "destructive")))
  
  adm = tp_to_adm(t = 1:3, h = c(2,3,3))
  expect_equal(get_time(adm, 3, hiat_mode = "end", bdry_pts_hiat = "consistent"), 3)
  expect_true(is.na(get_time(adm, 3, hiat_mode = "end", bdry_pts_hiat = "destructive")))
})



