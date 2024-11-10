test_that("check_city_validity works with valid and invalid inputs", {
  expect_type(check_city_validity("Lausanne", "test_key"), "logical")
  expect_error(check_city_validity(123, "test_key"), "The city_name argument must be a character string.")
})
