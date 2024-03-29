test_that("Return list of lenght 0 for no hiatuses",{
  adm = tp_to_adm(t = c(1,2), h = c(1,2))
  expect_equal(length(get_hiat_list(adm)),0)
})


test_that("Correct answer for 1 hiatus", {
  adm = tp_to_adm(t = 1:4, h = c(1,2,2,3))
  hiat_li = get_hiat_list(adm)
  expect_equal(hiat_li[[1]], c("height"=2, "start" = 2, "end" = 3))
  # start with hiatus
  adm = tp_to_adm(t = 1:4, h = c(1,1,2,3))
  hiat_li = get_hiat_list(adm)
  expect_equal(hiat_li[[1]], c("height"= 1, "start" = 1, "end" = 2))
  
  # end with hiatus
  adm = tp_to_adm(t = 1:4, h = c(1,2,3,3))
  hiat_li = get_hiat_list(adm)
  expect_equal(hiat_li[[1]], c("height"= 3, "start" = 3, "end" = 4))
})

test_that("Hiatuses with multiple tie points are counted as one", {
  adm = tp_to_adm(t = 1:5, h = c(1,2,2,2,3))
  hiat_li = get_hiat_list(adm)
  expect_equal(hiat_li[[1]], c("height"= 2, "start" = 2, "end" = 4))
})

test_that("Correct answer for multiple hiatuses", {
  h = c(1,1,2,2,3,3)
  t = 1:6
  adm = tp_to_adm(t = t, h = h)
  hiat_li = get_hiat_list(adm)
  expect_equal(hiat_li[[1]], c("height"= 1, "start" = 1, "end" = 2))
  expect_equal(hiat_li[[2]], c("height"= 2, "start" = 3, "end" = 4))
  expect_equal(hiat_li[[3]], c("height"= 3, "start" = 5, "end" = 6))
})

