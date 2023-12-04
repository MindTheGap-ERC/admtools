test_that("No accumulation returns thickness 0", {
  adm = tp_to_adm(t = c(1,2), h = c(1,1))
  expect_equal(get_total_thickness(adm), 0)
})

test_that("returns correct thickness in standard case", {
  adm = tp_to_adm(t = c(1,2), h = c(1,2))
  expect_equal(get_total_thickness(adm), 1)
})
