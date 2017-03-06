context("Test get_env")

test_that("Functions fail when env variables are not set.", {

  sid <- Sys.getenv("TWILIO_SID")
  Sys.setenv(TWILIO_SID = "")
  expect_error(tw_send_message("2125557634", "9178675903", "Hello from R!"))
  Sys.setenv(TWILIO_SID = sid)

  token <- Sys.getenv("TWILIO_TOKEN")
  Sys.setenv(TWILIO_TOKEN = "")
  expect_error(tw_send_message("2125557634", "9178675903", "Hello from R!"))
  Sys.setenv(TWILIO_TOKEN = token)

})
