# Twilio

[![Travis-CI Build Status](https://travis-ci.org/seankross/twilio.svg?branch=master)](https://travis-ci.org/seankross/twilio)

An interface to the [Twilio API](https://www.twilio.com/) for R. You'll need to
create an account at https://www.twilio.com/, then obtain an Account SID and
an Auth Token.

## Installation

```r
library(ghit)
install_github("seankross/twilio")
```

## Demos

### Set Up Authentication

You should only need to do this once per session.

```r
Sys.setenv(TWILIO_SID = "M9W4Ozq8BFX94w5St5hikg7UV0lPpH8e56")
Sys.setenv(TWILIO_TOKEN = "483H9lE05V0Jr362eq1814Li2N1I424t")
```

### Send a Text Message

```r
send_message("2125557634", "9178675903", "Hello from R 👋")
```

### Send a Picture Message

```r
send_message("2125557634", "9178675903", "https://www.r-project.org/logo/Rlogo.png")
```

### Send a Picture Message with Text

```r
send_message("2125557634", "9178675903", "Do you like the new logo?", "https://www.r-project.org/logo/Rlogo.png")
```

### Get Message Logs

```r
messages <- get_messages()
```

### Get Media from a Message

```r
gmedia <- et_message_media(messages[[1]]$sid)
`browseURL(media[[1]]$url)
``
