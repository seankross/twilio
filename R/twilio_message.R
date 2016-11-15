twilio_message <- function(parsed_message){
  parsed_message$account_sid <- NULL
  parsed_message$messaging_service_sid <- NULL
  parsed_message$uri <- NULL
  parsed_message$subresource_uris <- NULL

  structure(
    parsed_message,
    class = "twilio_message"
  )
}

#' @export
print.twilio_message <- function(x, ...){
  cat("From: ", x$from, "\n",
      "To: ", x$to, "\n",
      "Body: ", x$body, "\n",
      "Status: ", x$status, sep = "")
  invisible(x)
}
