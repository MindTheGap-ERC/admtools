test_that("Erosion between tie points is marked as destructive",{
  adm = tp_2_adm(t = 1:4, h = c(1,2,2,3))
  expect_true(is_destructive(adm = adm, t = 2.5, mode = "rcll"))
  expect_true(is_destructive(adm = adm, t = 2.5, mode = "lcrl"))
})

test_that("Boundaries of erosion intervals are identified",{
  adm = tp_2_adm(t = 1:4, h = c(1,2,2,3))
  expect_false(is_destructive(adm = adm, t = 3, mode = "rcll"))
  expect_true(is_destructive(adm = adm, t = 2, mode = "rcll"))
  
  expect_true(is_destructive(adm = adm, t = 3, mode = "lcrl"))
  expect_false(is_destructive(adm = adm, t = 2, mode = "lcrl"))
  
  expect_true(is_destructive(adm = adm, t = 3, mode = "closed"))
  expect_true(is_destructive(adm = adm, t = 2, mode = "closed"))
  
  expect_false(is_destructive(adm = adm, t = 3, mode = "open"))
  expect_false(is_destructive(adm = adm, t = 2, mode = "open"))
})
