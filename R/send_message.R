library(httr)
library(jsonlite)

get_sid <- function(){
  sid <- Sys.getenv("TWILIO_SID")
  if(identical(sid, "")){
    stop("Please set environmental variable TWILIO_SID.",
         call. = FALSE)
  }

  sid
}

get_token <- function(){
  token <- Sys.getenv("TWILIO_TOKEN")
  if(identical(token, "")){
    stop("Please set environmental variable TWILIO_TOKEN.",
         call. = FALSE)
  }

  token
}

#' @importFrom jsonlite fromJSON
#' @importFrom httr modify_url POST authenticate http_type status_code
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

  if(!(status_code(resp) %in% 200:201)){
    stop(
      sprintf(
        "Twilio API request failed [%s]\n%s\n<%s>",
        status_code(resp),
        parsed$message,
        parsed$more_info
      ),
      call. = FALSE
    )
  }

  parsed$account_sid <- NULL
  parsed$messaging_service_sid <- NULL
  parsed$uri <- NULL
  parsed$subresource_uris <- NULL

  structure(
    parsed,
    class = "sent_message"
  )
}

print.sent_message <- function(x, ...){
  cat("From: ", x$from, "\n",
      "To: ", x$to, "\n",
      "Body: ", x$body, "\n",
      "Status: ", x$status, sep = "")
  invisible(x)
}

#' @importFrom jsonlite fromJSON
#' @importFrom httr modify_url GET authenticate http_type status_code
get_messages <- function(){
  base_url <- "https://api.twilio.com/"
  path <- paste("2010-04-01", "Accounts", get_sid(), "Messages.json", sep = "/")
  url <- modify_url(base_url, path = path)
  resp <- GET(url, authenticate(get_sid(), get_token()))

  if(http_type(resp) != "application/json"){
    stop("Twilio API did not return JSON.", call. = FALSE)
  }
  parsed <- fromJSON(content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)
  parsed
}

