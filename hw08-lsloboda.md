hw08-lsloboda
================

-   [Making a Shiny app](#making-a-shiny-app)
    -   [Problem](#problem)
    -   [Method](#method)
    -   [Code](#code)
    -   [App Deployment](#app-deployment)
    -   [Image Sources](#image-sources)
    -   [Resources](#resources)

Making a Shiny app
==================

Problem
-------

The objective of the assignment is to add three features to the BC Liquor Shiny app and deploy it.

Method
------

I added three new features to the app, as follows:

1.  Modify the output through a functional widget that sorts the results by price.

2.  Change the UI by adding a few images.

3.  Use the DT package to turn the current results table into an interactive table.

Next I deployed the app to shinyapp.io to share it with the world!

Code
----

The app code consists of two main parts: the user interface (UI) and the server. The UI determines the visual appearance of the app on the page, while the server side handles the data processing and manipulation.

``` r
# library(shiny)
# library(tidyverse)
# library(DT)
# 
# bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
# 
# 
# ui <- fluidPage(
#   titlePanel("BC Liquor price app", 
#                        windowTitle = "BCL app"),
#   sidebarLayout(
#       sidebarPanel(
#           #img(src = "drinks.jpg", align = "right", width = 250, height = 100),
#           sliderInput("priceInput", "Select your desired price range.",
#                                   min = 0, max = 100, value = c(15, 30), pre="$"),
#           radioButtons("typeInput", "Select your alcoholic beverage type.", 
#                                    choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
#                                    selected = "WINE"),
#           uiOutput("countryOutput"),
#           checkboxInput("sortInput", "Sort by ascending price?",
#                                       value = FALSE),
#           conditionalPanel(condition = "input.typeInput == 'WINE'",
#                                            sliderInput("wineInput", "Select desired sweetness level:",
#                                                                   min = 0, max = 10, value = c(0, 10))
#           )
#       ),
#       mainPanel(
#           img(src = "bcl-image.png", align = "right", width = 550, height = 55),
#           plotOutput("coolplot"),
#           DT::dataTableOutput("bcl_data")
#       )
#   )
# )
# 
# server <- function(input, output) {
#   output$countryOutput <- renderUI({
#       selectInput("countryInput", "Country",
#                               sort(unique(bcl$Country)),
#                               selected = "CANADA")
#   })
#   
#   bcl_price <- reactive({
#       if (input$sortInput) {
#           bcl %>% 
#               filter(Price < input$priceInput[2],
#                            Price > input$priceInput[1],
#                            Type == input$typeInput)  %>%
#               arrange(Price)
#           
#       } else {
#           bcl %>% 
#               filter(Price < input$priceInput[2],
#                            Price > input$priceInput[1],
#                            Type == input$typeInput)       
#       }
#   })
#   bcl_sweet <- reactive({
#       if (input$typeInput == 'WINE') {
#           bcl_price() %>% 
#               filter(Type == 'WINE',
#                            Sweetness <= input$wineInput[2],
#                            Sweetness >= input$wineInput[1])
#       } else {
#           bcl_price()
#       }
#   })
#   output$coolplot <- renderPlot({
#       bcl_sweet() %>% 
#           ggplot(aes(Price)) +
#           geom_histogram()
#   })
#   output$bcl_data <- DT::renderDataTable({
#       bcl_sweet()
#   })
#   
#       }
# 
# shinyApp(ui = ui, server = server)
```

App Deployment
--------------

I setup an account on shinyapp.io and linked it with my github account. I installed the rsConnect() package, loaded the library, then used deployApp() to create the web app, found [here](https://lsloboda.shinyapps.io/hw08-lsloboda/)!

Image Sources
-------------

<https://vinepair.com/articles/wine-sour-beer-guide/>

<https://www.shopparkroyal.com/store/bc-liquor-store/>

Resources
---------

The seed code and data are from [Dean Attali's tutorial](https://deanattali.com/blog/building-shiny-apps-tutorial). The code can specifically be found [here](https://deanattali.com/blog/building-shiny-apps-tutorial/#12-final-shiny-app-code).

<https://stackoverflow.com/questions/21996887/embedding-image-in-shiny-app>

<https://shiny.rstudio.com/articles/images.html>

<https://shiny.rstudio.com/reference/shiny/0.14/checkboxInput.html>
