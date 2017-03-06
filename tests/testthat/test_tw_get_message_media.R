context("Test tw_get_message_media()")

test_that("tw_get_message_media() can retrieve a photo", {
  skip_on_cran()

  media <- tw_get_message_media(Sys.getenv("MEDIA_MESSAGE_SID"))

  expect_true(length(media) > 0)
  expect_equal(media[[1]]$content_type, "image/jpeg")
})
