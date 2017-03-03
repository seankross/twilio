#' Make a Data Frame from a Messages List
#'
#' Useful for turning a \code{twilio_messages_list} into a tidy data set.
#'
#' @param messages_list An S3 object with the class \code{twilio_messages_list}. Likely
#'   the result of a call to \code{\link{tw_get_messages_list}}.
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
#' messages <- tw_get_messages_list()
#'
#' # Create data frame from log
#' sms_data <- tw_message_tbl(messages)
#'
#' }
tw_message_tbl <- function(messages_list){
  stopifnot(identical(class(messages_list), "twilio_messages_list"))

  raw_log <- as.data.frame(do.call(rbind, messages_list), stringsAsFactors = FALSE)
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
