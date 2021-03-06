#' Get Media from a Message
#'
#' Media items that are attached to MMS messages, including photos and videos
#' are stored by Twilio. This function returns a list of \code{twilio_media}
#' objects, one for each piece of media in an MMS. Each object contains
#' information about that piece of media including its URL, Media SID, and
#' content type.
#'
#' @param message_sid An SID for a message that contains media.
#' @return A list containing media information.
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
#' # Get media information from a message
#' tw_get_message_media("MMo8Jw86Lj6422NzWgb8QxXlD5c45U100v")
#'
#' }
tw_get_message_media <- function(message_sid){
  base_url <- "https://api.twilio.com/"
  ua <- user_agent("https://github.com/seankross/twilio")
  path <- paste("2010-04-01", "Accounts", get_sid(), "Messages", message_sid, "Media.json", sep = "/")
  url <- modify_url(base_url, path = path)
  resp <- GET(url, ua, authenticate(get_sid(), get_token()))

  if(http_type(resp) != "application/json"){
    stop("Twilio API did not return JSON.", call. = FALSE)
  }

  parsed <- fromJSON(content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)

  check_status(resp)

  media <- map(parsed$media_list, function(x){
                                    structure(
                                      list(sid = x$sid,
                                           message_sid = x$parent_sid,
                                           content_type = x$content_type),
                                      class = "twilio_media"
                                    )
                                  })

  for(i in seq_along(media)){
    media_path <- paste("2010-04-01", "Accounts", get_sid(), "Messages",
                        message_sid, "Media", media[[i]]$sid,  sep = "/")
    media_url <- modify_url(base_url, path = media_path)
    media_resp <- GET(media_url, authenticate(get_sid(), get_token()))
    media[[i]]$url <- media_resp$url
  }

  media
}

#' @export
print.twilio_media <- function(x, ...){
  cat("URL: ", x$url, "\n",
      "Type: ", x$content_type, "\n", sep = "")
  invisible(x)
}
