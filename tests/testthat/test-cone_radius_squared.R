test_that("cone_radius_squared returns squared values", {
  expect_equal(cone_radius_squared(c(0, 5)), c(0, (5 / 8)^2))     # Expected squared result
  expect_error(cone_radius_squared("a"), "The x argument must be numeric.") # Non-numeric input error
  expect_type(cone_radius_squared(c(0, 5)), "double")             # Expected type for numeric input
})
