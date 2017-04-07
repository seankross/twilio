# Twilio

[![Travis-CI Build Status](https://travis-ci.org/seankross/twilio.svg?branch=master)](https://travis-ci.org/seankross/twilio)
[![CRAN version](http://www.r-pkg.org/badges/version/twilio)](https://cran.r-project.org/package=twilio)
[![Downloads](http://cranlogs.r-pkg.org/badges/twilio)](http://cran-logs.rstudio.com/)

An interface to the [Twilio API](https://www.twilio.com/) for R. You'll need to
create an account at https://www.twilio.com/, then obtain an Account SID and
an Auth Token.

## Installation

```r
install.packages("twilio")
```

Or download the latest development version:

```r
library(ghit)
install_github("seankross/twilio[dev]")
```

## Demos

### Set Up Authentication

You should only need to do this once per session.

```r
Sys.setenv(TWILIO_SID = "M9W4Ozq8BFX94w5St5hikg7UV0lPpH8e56")
Sys.setenv(TWILIO_TOKEN = "483H9lE05V0Jr362eq1814Li2N1I424t")

library(twilio)
```

### Send a Text Message to Brian

```r
tw_send_message("2125557634", "9178675903", "Hello from R 👋")
```

### Send a Picture Message

```r
tw_send_message("2125557634", "9178675903", media_url = "https://www.r-project.org/logo/Rlogo.png")
```

### Send a Picture Message with Text

```r
tw_send_message("2125557634", "9178675903", "Do you like the new logo?",
  "https://www.r-project.org/logo/Rlogo.png")
```

### Get Messages List

```r
messages <- tw_get_messages_list()
```

### Make a Data Frame from the Messages List

```r
sms_data <- tw_message_tbl(messages)
```

### Get Media from a Message

```r
media <- tw_get_message_media(sms_data$sid[1])
browseURL(media[[1]]$url)
```
