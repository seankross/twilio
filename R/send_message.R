#' Send an SMS or MMS Message
#'
#' @param to A phone number which will receieve the message.
#' @param from A phone number which will send the message.
#' @param body The body of the message.
#' @param media_url A url containing media to be sent in a message.
#' @return A \code{twilio_message} object.
#' @importFrom jsonlite fromJSON
#' @importFrom httr modify_url POST authenticate http_type content
#' @export
#' @examples
#' \dontrun{
#'
#' # Set API credentials
#' # You only need to do this once per R session
#' Sys.setenv(TWILIO_SID = "M9W4Ozq8BFX94w5St5hikg7UV0lPpH8e56")
#' Sys.setenv(TWILIO_TOKEN = "483H9lE05V0Jr362eq1814Li2N1I424t")
#'
#' # Send a simple text message
#' send_message("2125557634", "9178675903", "Hello from R!")
#'
#' # Send a picture message
#' send_message("2125557634", "9178675903", media_url = "https://www.r-project.org/logo/Rlogo.png")
#'
#' # Send a picture message with text
#' send_message("2125557634", "9178675903", "Do you like the new logo?",
#'     "https://www.r-project.org/logo/Rlogo.png")
#'
#' }
send_message <- function(to, from, body = NULL, media_url = NULL){
  if(is.null(body) && is.null(media_url)){
    stop("Please specify body, media_url, or both.",
         call. = FALSE)
  }

  base_url <- "https://api.twilio.com/"
  path <- paste("2010-04-01", "Accounts", get_sid(), "Messages.json", sep = "/")
  url <- modify_url(base_url, path = path)
  resp <- POST(url, authenticate(get_sid(), get_token()), body =
                 list(To = to,
                      From = from,
                      Body = body,
                      MediaUrl = media_url)
               )
  if(http_type(resp) != "application/json"){
    stop("Twilio API did not return JSON.", call. = FALSE)
  }

  parsed <- fromJSON(content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)

  check_status(resp)

  twilio_message(parsed)
}
