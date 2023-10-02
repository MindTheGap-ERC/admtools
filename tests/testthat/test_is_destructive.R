test_that("Erosion between tie points is marked as destructive",{
  adm = tp_2_adm(t = 1:4, h = c(1,2,2,3))
  expect_true(is_destructive(adm = adm, t = 2.5, mode = "rcll"))
  expect_true(is_destructive(adm = adm, t = 2.5, mode = "lcrl"))
  expect_true(is_destructive(adm = adm, t = 2.5, mode = "open"))
  expect_true(is_destructive(adm = adm, t = 2.5, mode = "closed"))
})

test_that("Non-erosion between tie points is not marked as destructive",{
  adm = tp_2_adm(t = 1:4, h = c(1,2,2,3))
  expect_false(is_destructive(adm = adm, t = 1.5, mode = "rcll"))
  expect_false(is_destructive(adm = adm, t = 1.5, mode = "lcrl"))
  expect_false(is_destructive(adm = adm, t = 1.5, mode = "open"))
  expect_false(is_destructive(adm = adm, t = 1.5, mode = "closed"))
})


test_that("Values outside domain are assigned correctly", {
  adm = tp_2_adm(t = 1:4, h = c(1,2,2,3))
  
  # by default NA is assigned 
  expect_true(is.na(is_destructive(adm, t = min(adm$t) - 1)))
  expect_true(is.na(is_destructive(adm, t = max(adm$t) + 1)))
  
  # outside values are set to NA
  expect_true(is.na(is_destructive(adm, t = min(adm$t) - 1,  out_dom_mode = "default")))
  expect_true(is.na(is_destructive(adm, t = max(adm$t) + 1,  out_dom_mode = "default")))
  
  # outside of domain destruction is expected
  expect_true(is_destructive(adm, t = min(adm$t) - 1,  out_dom_mode = "destructive"))
  expect_true(is_destructive(adm, t = max(adm$t) + 1,  out_dom_mode = "destructive"))
  
  # outside of domain preserved signal
  expect_false(is_destructive(adm, t = min(adm$t) - 1,  out_dom_mode = "conservative"))
  expect_false(is_destructive(adm, t = max(adm$t) + 1,  out_dom_mode = "conservative"))
  
  # throw error if out_dom_mode is not matching "default". "destructive", or "conservative"
  expect_error(is_destructive(adm, t = min(adm$t) - 1,  out_dom_mode = "something else"))
  expect_error(is_destructive(adm, t = max(adm$t) + 1,  out_dom_mode = 4))
  
})


test_that("Boundaries of erosion intervals are identified",{
  adm = tp_2_adm(t = 1:4, h = c(1,2,2,3))
  
  # right end of erosion is marked as non-destructive under rcll
  expect_false(is_destructive(adm = adm, t = 3, mode = "rcll"))
  # left end of erosion is marked as destructive under rcll
  expect_true(is_destructive(adm = adm, t = 2, mode = "rcll"))
  
  # right end of erosion is marked as destructive under lcrl
  expect_true(is_destructive(adm = adm, t = 3, mode = "lcrl"))
  # left end of erosion is marked as non-destructive under lcrl
  expect_false(is_destructive(adm = adm, t = 2, mode = "lcrl"))
  
  # both ends of erosion intervals are marked as destructive under "closed"
  expect_true(is_destructive(adm = adm, t = 3, mode = "closed"))
  expect_true(is_destructive(adm = adm, t = 2, mode = "closed"))
  
  # both ends of erosion intervals are marked as non-destructive under "open"
  expect_false(is_destructive(adm = adm, t = 3, mode = "open"))
  expect_false(is_destructive(adm = adm, t = 2, mode = "open"))
  
})

test_that("Boundary hiatuses are treated correctly", {
  
  adm1 = tp_2_adm(t = 1:4, h = c(1,1,2,3))
  adm2 = tp_2_adm(t = 1:4, h = c(1,2,3,3))
  
  # lower boundary points are destructive
  expect_true(is_destructive(adm1, t = 1, mode = "rcll", bdry_pts_hiat = "destructive"))
  expect_true(is_destructive(adm1, t = 1, mode = "lcrl", bdry_pts_hiat = "destructive"))
  expect_true(is_destructive(adm1, t = 1, mode = "open", bdry_pts_hiat = "destructive"))
  expect_true(is_destructive(adm1, t = 1, mode = "closed", bdry_pts_hiat = "destructive"))
  
  # upper boundary points are destructive
  expect_true(is_destructive(adm2, t = 4, mode = "rcll", bdry_pts_hiat = "destructive"))
  expect_true(is_destructive(adm2, t = 4, mode = "lcrl", bdry_pts_hiat = "destructive"))
  expect_true(is_destructive(adm2, t = 4, mode = "open", bdry_pts_hiat = "destructive"))
  expect_true(is_destructive(adm2, t = 4, mode = "closed", bdry_pts_hiat = "destructive"))
  
  
  expect_true(is_destructive(adm1, t = 1, mode = "rcll", bdry_pts_hiat = "consistent"))
  expect_false(is_destructive(adm1, t = 1, mode = "lcrl", bdry_pts_hiat = "consistent"))
  expect_false(is_destructive(adm1, t = 1, mode = "open", bdry_pts_hiat = "consistent"))
  expect_true(is_destructive(adm1, t = 1, mode = "closed", bdry_pts_hiat = "consistent"))
  
  expect_false(is_destructive(adm2, t = 4, mode = "rcll", bdry_pts_hiat = "consistent"))
  expect_true(is_destructive(adm2, t = 4, mode = "lcrl", bdry_pts_hiat = "consistent"))
  expect_false(is_destructive(adm2, t = 4, mode = "open", bdry_pts_hiat = "consistent"))
  expect_true(is_destructive(adm2, t = 4, mode = "closed", bdry_pts_hiat = "consistent"))
  
})



