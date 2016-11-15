context("Test get_env")

test_that("Functions fail when env variables are not set.", {
  Sys.setenv(TWILIO_SID = "")
  Sys.setenv(TWILIO_TOKEN = "")

  expect_error(send_message("2125557634", "9178675903", "Hello from R!"))
})
