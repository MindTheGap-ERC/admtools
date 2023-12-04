test_that("Requires multiadm class",
          {
            expect_false(is_multiadm(2))
            expect_false(is_multiadm(2, quietly = TRUE))
            expect_warning(is_multiadm(2, quietly = FALSE))
          })

test_that("Correct name fields required",{
  x = 2
  class(x) = "multiadm"
  
  expect_false(is_multiadm(x))
  expect_false(is_multiadm(x, quietly = TRUE))
  expect_warning(is_multiadm(x, quietly = FALSE))
  
})

test_that("Requires correct number of names",{
  x = list("t" = 2,
           "h" = 2,
           "destr" = 2,
           "no_of_entries" = 2,
           "T_unit" = NULL,
           "L_unit" = NULL)
  x[["foo"]] = 2
  expect_false(is_multiadm(x))
  expect_false(is_multiadm(x, quietly = TRUE))
  expect_warning(is_multiadm(x, quietly = FALSE))
  
})
