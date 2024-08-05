# You may need to adjust the API calls and prompt engineering to get the best results for patient education about osteoporosis and the TOM system.
# Remember to handle API rate limits, error cases, and to ensure 
# that the AI models are properly fine-tuned or prompted to provide accurate medical information about osteoporosis and the TOM system.


library(shiny)
library(chattr)
library(httr)
library(jsonlite)
library(rsconnect)

# Set up your shinyapps.io account in R
rsconnect::setAccountInfo(name='texchi2', token='439B5B85EDDDA8132241DB18376E4285', 
                          secret='bfjaqNWMIqS/GCJm3PZoZJAbpuK7gxal+jlb9aVJ')

# Deploy the app:
deployApp("~/2024MSC/TOM2")
