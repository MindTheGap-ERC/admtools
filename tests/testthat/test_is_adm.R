test_that("Returns False for non adm objects",
          {
            expect_false(is_adm(2))
            expect_false(is_adm(2, quietly = TRUE))
            expect_warning(is_adm(2, quietly = FALSE))
          })

test_that("Requires all name fields",
          {
            # correct adm
            adm = tp_2_adm(t = 1:3, h = 2:4)
            expect_true(is_adm(adm))
            expect_true(is_adm(adm, quietly = TRUE))
            expect_true(is_adm(adm, quietly = FALSE))
            # incorrect number of name fields
            adm_mod = adm
            adm_mod[["a"]] = "foo"
            expect_false(is_adm(adm_mod))
            expect_false(is_adm(adm_mod, quietly = TRUE))
            expect_warning(is_adm(adm_mod, quietly = FALSE))
            # missing name field
            adm_mod = adm
            adm_mod[["T_unit"]] = NULL
            expect_false(is_adm(adm_mod))
            expect_false(is_adm(adm_mod, quietly = TRUE))
            expect_warning(is_adm(adm_mod, quietly = FALSE))
          })


test_that("Detects flawed number of tie points",
          {
            adm = tp_2_adm(t = 1:3, h = 2:4)
            adm_mod = adm
            adm_mod$t = c(1,2)
            expect_false(is_adm(adm_mod))
            expect_false(is_adm(adm_mod, quietly = TRUE))
            expect_warning(is_adm(adm_mod, quietly = FALSE))
            
            adm_mod = adm
            adm_mod$h = c(1,2)
            expect_false(is_adm(adm_mod))
            expect_false(is_adm(adm_mod, quietly = TRUE))
            expect_warning(is_adm(adm_mod, quietly = FALSE))
            
            
            adm_mod = adm
            adm_mod$destr = c(TRUE)
            expect_false(is_adm(adm_mod))
            expect_false(is_adm(adm_mod, quietly = TRUE))
            expect_warning(is_adm(adm_mod, quietly = FALSE))
            
          })

test_that("tie points in time must be strictly increasing",{
  adm = tp_2_adm(t = 1:3, h = 2:4)
  adm$t = c(1,1,3)
  
  expect_false(is_adm(adm))
  expect_false(is_adm(adm, quietly = TRUE))
  expect_warning(is_adm(adm, quietly = FALSE))
  
  adm$t = c(1,0,3)
  expect_false(is_adm(adm))
  expect_false(is_adm(adm, quietly = TRUE))
  expect_warning(is_adm(adm, quietly = FALSE))
})

test_that("strat tie point must obey the law of superposition",{
  adm = tp_2_adm(t = 1:3, h = 2:4)
  adm$h = c(2,1,4)
  
  expect_false(is_adm(adm))
  expect_false(is_adm(adm, quietly = TRUE))
  expect_warning(is_adm(adm, quietly = FALSE))
})
