context("Test tw_get_messages_list()")

test_that("Test that tw_get_messages_list() will retrieve messages", {
  skip_on_cran()

  messages <- tw_get_messages_list()
  expect_true(length(messages) > 0)
  expect_equal(class(messages), "twilio_messages_list")
  expect_equal(class(messages[[1]]), "twilio_message")
})
