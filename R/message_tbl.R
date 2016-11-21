#' Make a Data Frame from Message Logs
#'
#' @param message_log An S3 object with the class \code{twilio_message_log}. Likely
#'   the result of a call to \code{\link{get_messages}}.
#' @return A data frame.
#'
#' @importFrom magrittr %>% %<>%
#' @importFrom purrr map map_if
#' @importFrom lubridate parse_date_time
#' @export
#' @examples
#' \dontrun{
#'
#' # Set API credentials
#' # You only need to do this once per R session
#' Sys.setenv(TWILIO_SID = "M9W4Ozq8BFX94w5St5hikg7UV0lPpH8e56")
#' Sys.setenv(TWILIO_TOKEN = "483H9lE05V0Jr362eq1814Li2N1I424t")
#'
#' # Get messages sent to your account
#' messages <- get_messages()
#'
#' # Create data frame from log
#' sms_data <- message_tbl(messages)
#'
#' }
message_tbl <- function(message_log){
  stopifnot(identical(class(message_log), "twilio_message_log"))

  raw_log <- as.data.frame(do.call(rbind, message_log), stringsAsFactors = FALSE)
  raw_log$date_created %<>% map(parse_date_time, orders = "%a %d %b %Y %H:%M:%S %z")
  raw_log$date_created <- do.call(c, raw_log$date_created)
  raw_log$date_updated %<>% map(parse_date_time, orders = "%a %d %b %Y %H:%M:%S %z")
  raw_log$date_updated <- do.call(c, raw_log$date_updated)
  raw_log$date_sent %<>% map(parse_date_time, orders = "%a %d %b %Y %H:%M:%S %z")
  raw_log$date_sent <- do.call(c, raw_log$date_sent)
  raw_log$error_code %<>% map(function(x){ifelse(is.null(x), NA, x)}) %>% unlist()
  raw_log$error_message %<>% map(function(x){ifelse(is.null(x), NA, x)}) %>% unlist()
  raw_log %>% map_if(is.list, unlist) %>% as.data.frame(stringsAsFactors = FALSE)
}
