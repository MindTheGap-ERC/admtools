test_that("Requires multiadm class",
          {
            expect_false(suppressWarnings(is_multiadm(2)))
          })