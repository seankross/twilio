context("Test tw_message_tbl()")

test_that("tw_message_tbl() can read in a twilio_messages_list", {
  messages_list <- structure(list(
    structure(list(sid = "SM1jtHMmhOCv90MA3XZiMinXbSY94EPVca", date_created = "Mon, 21 Nov 2016 19:45:47 +0000",
                   date_updated = "Mon, 21 Nov 2016 19:45:48 +0000", date_sent = "Mon, 21 Nov 2016 19:45:47 +0000",
                   to = "+12125557634", from = "+19178675903", body = "Sent from your Twilio trial account - 2016-11-21 14:44:39",
                   status = "delivered", num_segments = "1", num_media = "0",
                   direction = "outbound-api", api_version = "2010-04-01", price = "-0.00750",
                   price_unit = "USD", error_code = NULL, error_message = NULL), .Names = c("sid",
                                                                                            "date_created", "date_updated", "date_sent", "to", "from", "body",
                                                                                            "status", "num_segments", "num_media", "direction", "api_version",
                                                                                            "price", "price_unit", "error_code", "error_message"), class = "twilio_message"),
    structure(list(sid = "MMH82TU6tVCbGsspcDnvJU47JuTizM3DdE", date_created = "Tue, 15 Nov 2016 15:56:05 +0000",
                   date_updated = "Tue, 15 Nov 2016 15:56:07 +0000", date_sent = "Tue, 15 Nov 2016 15:56:07 +0000",
                   to = "+19178675903", from = "+12125557634", body = "", status = "received",
                   num_segments = "1", num_media = "1", direction = "inbound",
                   api_version = "2010-04-01", price = "-0.01000", price_unit = "USD",
                   error_code = NULL, error_message = NULL), .Names = c("sid",
                                                                        "date_created", "date_updated", "date_sent", "to", "from", "body",
                                                                        "status", "num_segments", "num_media", "direction", "api_version",
                                                                        "price", "price_unit", "error_code", "error_message"), class = "twilio_message")
  ), class = "twilio_messages_list")

  message_table <- tw_message_tbl(messages_list)

  expect_true(is.data.frame(message_table))
  expect_equal(nrow(message_table), 2)
})
