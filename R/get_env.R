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
