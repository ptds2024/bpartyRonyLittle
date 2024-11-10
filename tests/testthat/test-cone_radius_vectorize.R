test_that("cone_radius_vectorize works for numeric vectors", {
  expect_equal(cone_radius_vectorize(c(0, 5, -1)), c(0, 5 / 8, 0)) # Expected vector result
  expect_error(cone_radius_vectorize("a"), "The x argument must be numeric.") # Non-numeric input error
  expect_type(cone_radius_vectorize(c(0, 5, -1)), "double")       # Expected type for numeric input
})
