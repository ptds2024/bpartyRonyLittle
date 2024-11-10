test_that("cone_radius returns expected radius values", {
  # Basic known values
  expect_equal(cone_radius(5), 5 / 8)                    # Within the first range (x < 8)
  expect_equal(cone_radius(8), 1)                        # Boundary of first and second range
  expect_equal(cone_radius(8 + pi / 4), 1 + 1.5 * sin(pi / 4))  # Within the sine range
  expect_equal(cone_radius(10), 0)                       # Outside defined range

  # Out-of-bound values
  expect_equal(cone_radius(-1), 0)                       # Negative value

  # Invalid input
  expect_error(cone_radius("a"), "The x argument must be numeric.")  # Non-numeric input error
})
