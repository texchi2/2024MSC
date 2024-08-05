#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(chattr)
library(httr)
library(jsonlite)

# Function to call Llama 3 API (you'll need to replace with actual API endpoint)
call_llama3 <- function(prompt) {
  response <- POST(
    "https://api.llama3.com/v1/chat/completions",
    add_headers("Authorization" = "Bearer YOUR_LLAMA3_API_KEY"),
    body = list(
      model = "llama-3",
      messages = list(list(role = "user", content = prompt))
    ),
    encode = "json"
  )
  content(response)$choices[[1]]$message$content
}

# Function to call Claude 3.5 API (you'll need to replace with actual API endpoint)
call_claude35 <- function(prompt) {
  response <- POST(
    "https://api.anthropic.com/v1/chat/completions",
    add_headers("Authorization" = "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"),
    body = list(
      model = "claude-3.5",
      messages = list(list(role = "user", content = prompt))
    ),
    encode = "json"
  )
  content(response)$choices[[1]]$message$content
}

# Define UI
ui <- fluidPage(
  titlePanel("TOM Patient Education Chatbot"),
  sidebarLayout(
    sidebarPanel(
      selectInput("model", "Choose AI Model:",
                  choices = c("Llama 3", "Claude 3.5"))
    ),
    mainPanel(
      chattr_ui("chat")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  chattr_server("chat", 
                welcome_message = "Welcome to the TOM Patient Education Chatbot. How can I help you today?",
                on_submit = function(message, chat_history) {
                  prompt <- paste(chat_history, message, sep = "\n")
                  if (input$model == "Llama 3") {
                    response <- call_llama3(prompt)
                  } else {
                    response <- call_claude35(prompt)
                  }
                  return(response)
                })
}

# Run the app
shinyApp(ui = ui, server = server)
