message_log_tbl <- function(message_log){
  stopifnot(identical(class(message_log), "twilio_message_log"))
  as.data.frame(do.call(rbind, message_log), stringsAsFactors = FALSE)
}
