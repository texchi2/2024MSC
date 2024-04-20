library(jsonlite)
library(httpuv)

# Function to handle POST requests
handle_post <- function(req) {
  # Parse JSON data from request body
  data <- jsonlite::fromJSON(rawToChar(req$rook.input$read()))
  
  # Append data to online_registration.txt
  write(jsonlite::toJSON(data), "_data/online_registration.txt", append = TRUE)
  
  # Send response
  list(
    status = 200L,
    headers = list("Content-Type" = "application/json"),
    body = jsonlite::toJSON(list(message = "Registration successful"))
  )
}

# Start server
httpuv::runServer("0.0.0.0", 8080, list(
  call = function(req) {
    if (req$REQUEST_METHOD == "POST") {
      handle_post(req)
    } else {
      list(
        status = 404L,
        body = "Not Found"
      )
    }
  }
))


