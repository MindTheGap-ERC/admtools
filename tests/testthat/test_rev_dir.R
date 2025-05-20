test_that("double transformation returns original object",{
  t = ape::rbdtree(birth = 3, death = 1, Tmax = 2)
  # simulate taxonomy along the tree
  s = FossilSim::sim.taxonomy(tree = t)
  # simulate fossils based on taxonomy
  f = FossilSim::sim.fossils.poisson(rate = 4, taxonomy = s)
  expect_identical(f, f |> rev_dir( ref = 0) |> rev_dir( ref = 0))
  expect_identical(s, s |> rev_dir( ref = 0) |> rev_dir( ref = 0))
})
