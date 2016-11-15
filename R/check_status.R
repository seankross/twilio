#' @importFrom httr status_code
#' @importFrom jsonlite fromJSON
check_status <- function(resp){
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
}
