library(shiny)
library(tidyverse)
library(DT)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)


ui <- fluidPage(
	titlePanel("BC Liquor price app", 
						 windowTitle = "BCL app"),
	sidebarLayout(
		sidebarPanel(
			#img(src = "drinks.jpg", align = "right", width = 250, height = 100),
			sliderInput("priceInput", "Select your desired price range.",
									min = 0, max = 100, value = c(15, 30), pre="$"),
			radioButtons("typeInput", "Select your alcoholic beverage type.", 
									 choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
									 selected = "WINE"),
			uiOutput("countryOutput"),
			checkboxInput("sortInput", "Sort by ascending price?",
										value = FALSE),
			conditionalPanel(condition = "input.typeInput == 'WINE'",
											 sliderInput("wineInput", "Select desired sweetness level:",
											 						min = 0, max = 10, value = c(0, 10))
			)
		),
		mainPanel(
			img(src = "bcl-image.png", align = "right", width = 550, height = 55),
			plotOutput("coolplot"),
			DT::dataTableOutput("bcl_data")
		)
	)
)

server <- function(input, output) {
	output$countryOutput <- renderUI({
		selectInput("countryInput", "Country",
								sort(unique(bcl$Country)),
								selected = "CANADA")
	})
	
	bcl_price <- reactive({
		if (input$sortInput) {
			bcl %>% 
				filter(Price < input$priceInput[2],
							 Price > input$priceInput[1],
							 Type == input$typeInput)  %>%
				arrange(Price)
			
		} else {
			bcl %>% 
				filter(Price < input$priceInput[2],
							 Price > input$priceInput[1],
							 Type == input$typeInput)       
		}
	})
	bcl_sweet <- reactive({
		if (input$typeInput == 'WINE') {
			bcl_price() %>% 
				filter(Type == 'WINE',
							 Sweetness <= input$wineInput[2],
							 Sweetness >= input$wineInput[1])
		} else {
			bcl_price()
		}
	})
	output$coolplot <- renderPlot({
		bcl_sweet() %>% 
			ggplot(aes(Price)) +
			geom_histogram()
	})
	output$bcl_data <- DT::renderDataTable({
		bcl_sweet()
	})
	
		}

shinyApp(ui = ui, server = server)