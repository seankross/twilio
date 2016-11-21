#' Get Logs of Messages Sent to Your Account
#'
#' @param page The page number of the log you would like to retrieve. Starts at zero.
#' @param page_size The number of messages per page. The maximum number allowed is 1000.
#' @return A \code{twilio_message_log} object.
#' @importFrom jsonlite fromJSON
#' @importFrom httr modify_url GET authenticate http_type content user_agent
#' @importFrom purrr map
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
#' }
get_messages <- function(page = 0, page_size = 50){
  base_url <- "https://api.twilio.com/"
  ua <- user_agent("https://github.com/seankross/twilio")
  path <- paste("2010-04-01", "Accounts", get_sid(), "Messages.json", sep = "/")
  url <- modify_url(base_url, path = path, query = list(page = page, pagesize = page_size))
  resp <- GET(url, ua, authenticate(get_sid(), get_token()))

  if(http_type(resp) != "application/json"){
    stop("Twilio API did not return JSON.", call. = FALSE)
  }

  parsed <- fromJSON(content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)

  check_status(resp)

  structure(
    map(parsed$messages, twilio_message),
    class = "twilio_message_log"
  )
}

