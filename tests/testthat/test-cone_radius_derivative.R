test_that("cone_radius_derivative calculates approximate derivative", {
  expect_type(cone_radius_derivative(c(5, 0)), "double")          # Expected type for numeric input
  expect_error(cone_radius_derivative("a"), "The x argument must be numeric.") # Non-numeric input error
  expect_equal(length(cone_radius_derivative(c(5, 0))), 2)        # Check output length matches input
})
