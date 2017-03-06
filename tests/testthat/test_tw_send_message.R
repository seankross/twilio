context("Test tw_send_message()")

test_that("tw_send_message() can send messages", {
  skip_on_cran()

  sid <- Sys.getenv("TWILIO_SID")
  token <- Sys.getenv("TWILIO_TOKEN")
  Sys.setenv(TWILIO_SID = Sys.getenv("TWILIO_SID_TEST"))
  Sys.setenv(TWILIO_TOKEN = Sys.getenv("TWILIO_TOKEN_TEST"))

  txt <- tw_send_message("2127872000", "+15005550006",
                                      "Half a pound of whitefish salad please.")

  expect_equal(class(txt), "twilio_message")
  expect_equal(txt$from, "+15005550006")

  Sys.setenv(TWILIO_SID = sid)
  Sys.setenv(TWILIO_TOKEN = token)
})
