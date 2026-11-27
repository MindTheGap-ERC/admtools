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



test_that("interpolation next to hiatuses is not affected by the hiatus", {
  # hiatus at h = 2 from t = 2 to t = 3, see issue #37
  adm = tp_to_adm(t = 1:4, h = c(1,2,2,3))
  h = c(1, 1.5, 2, 2.5, 3)
  expect_equal(get_time(adm, h, hiat_mode = "start", bdry_pts_hiat = "consistent"), c(1, 1.5, 2, 3.5, 4))
  expect_equal(get_time(adm, h, hiat_mode = "end", bdry_pts_hiat = "consistent"), c(1, 1.5, 3, 3.5, 4))
  
  # hiatuses at start and end of adm
  adm = tp_to_adm(t = 1:4, h = c(1,1,2,2))
  expect_equal(get_time(adm, c(1, 1.5, 2), hiat_mode = "start", bdry_pts_hiat = "consistent"), c(1, 2.5, 3))
  expect_equal(get_time(adm, c(1, 1.5, 2), hiat_mode = "end", bdry_pts_hiat = "consistent"), c(2, 2.5, 4))
})

test_that("adm consisting only of a hiatus is handled", {
  adm = tp_to_adm(t = 1:3, h = c(2,2,2))
  expect_equal(get_time(adm, 2, hiat_mode = "start", bdry_pts_hiat = "consistent"), 1)
  expect_equal(get_time(adm, 2, hiat_mode = "end", bdry_pts_hiat = "consistent"), 3)
  expect_true(is.na(get_time(adm, 3)))
})

test_that("get_time and get_height are inverses of each other", {
  set.seed(42)
  for (k in 1:200){
    n = sample(3:10, 1)
    t = sort(stats::runif(n))
    dh = stats::runif(n - 1) * (stats::runif(n - 1) > 0.4) # random hiatuses
    adm = tp_to_adm(t = t, h = cumsum(c(0, dh)))
    
    # strat -> time -> strat
    h = stats::runif(20, min(adm$h), max(adm$h))
    for (hm in c("start", "end")){
      t_h = get_time(adm, h, hiat_mode = hm, bdry_pts_hiat = "consistent")
      expect_equal(get_height(adm, t_h, destructive = FALSE), h)
    }
    
    # time -> strat -> time, for times outside of hiatuses
    t_s = stats::runif(20, min(adm$t), max(adm$t))
    h_t = get_height(adm, t_s)
    keep = !is.na(h_t)
    expect_equal(get_time(adm, h_t[keep], bdry_pts_hiat = "consistent"), t_s[keep])
  }
})
