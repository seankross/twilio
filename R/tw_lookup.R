#' Twilio Lookup 
#' 
#' Fetch number info from Twilio's number lookup service. Useful for validating numbers.
#' 
#' @param num A phone number to lookup.
#' @param is_valid Return raw API output or logical that indicates whether \code{num} is valid (default).
#' @param country_code The ISO country code of the phone number to fetch. This is used to specify the country when the phone number is provided in a national format.
#' 
#' @return A \code{list} or \code{logical} based on the \code{is_valid} flag.
#' 
#' @examples
#' \dontrun{
#'
#' # Set API credentials
#' # You only need to do this once per R session
#' Sys.setenv(TWILIO_SID = "M9W4Ozq8BFX94w5St5hikg7UV0lPpH8e56")
#' Sys.setenv(TWILIO_TOKEN = "483H9lE05V0Jr362eq1814Li2N1I424t")
#'
#' # Get messages sent to your account
#' tw_lookup("+41757105871")
#'
#' }
#' @importFrom httr parse_url build_url GET authenticate
#' @importFrom utils URLencode
#' @export
tw_lookup <- function(num, is_valid = FALSE, country_code="US") {
  url <- parse_url("https://lookups.twilio.com/v1/PhoneNumbers")
  url$path <- append(url$path, URLencode(num))
  url$query <- list(Type = "carrier", CountryCode = country_code)
  url <- build_url(url)
  resp <- GET(url, authenticate(get_sid(), get_token()))
  parse_lookup(resp, is_valid)
}

#' @keywords Internal
#' @noRd
#' @importFrom httr content status_code
parse_lookup <- function(resp, is_valid) {
  out <- content(resp, encoding = "UTF-8")
  if(!(status_code(resp) %in% 200:201)){
    warning(
      sprintf(
        "Twilio API request failed [%s]\n%s\n<%s>",
        status_code(resp),
        out$message,
        out$more_info
      ),
      call. = FALSE
    )
    out <- FALSE
  } else if (is_valid) {
    out <- TRUE
  }
  out
}