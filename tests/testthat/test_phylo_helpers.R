test_that("root node is correctly identified",
          {
            set.seed(1)
            tr = ape::rtopology(4)
            expect_equal(admtools:::find_root_node(tr), 5)
          })

test_that("recursor nodes are correctly identified",{
  set.seed(1)
  tr = ape::rtopology(4)
  expect_equal(admtools:::find_precursor_node(tr, 6), 5)
  
  expect_true(length(admtools:::find_precursor_node(tr, find_root_node(tr)))== 0)
})
