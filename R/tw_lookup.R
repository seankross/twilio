#' @title tw_lookup
#' @description Fetch number info from \href{https://www.twilio.com/docs/lookup}{Twilio's number lookup service}. Useful for validating numbers.
#' @param num \code{(character)} of the number to lookup
#' @param is_valid \code{(logical)} \code{FALSE} (*Default*) returns the info returned by the API as a list, or \code{FALSE} for invalid numbers. \code{TRUE} will return a logical that indicates whether \code{num} is valid. Useful for subsetting.
#' @return A \code{list} or \code{logical} based on the \code{is_valid} flag.
#' @export

tw_lookup <- function(num, is_valid = FALSE) {
  .url <- httr::parse_url("https://lookups.twilio.com/v1/PhoneNumbers")
  .url$path <- append(.url$path, utils::URLencode(num))
  .url$query <- list(Type = "carrier", CountryCode = "US")
  .url <- httr::build_url(.url)
  .resp <- httr::GET(.url, authenticate(get_sid(), get_token()))
  parse_lookup(.resp, is_valid)
}

