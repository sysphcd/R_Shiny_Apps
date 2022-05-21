library(shiny)
data("airquality")

# Define UI for app 
ui<-fluidPage(
  titlePanel("Ozone Level!"),
  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: #dd1c77}")),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId= "bins",
                  label="Number of bins:",
                  min =1,
                  max=50,
                  value=30,
                  step=5
      )
    
  ),
  mainPanel(
      plotOutput(outputId="distPlot")
  ))
)

# Define server logic require 
server <- function(input, output){
  output$distPlot <- renderPlot({
    x <- airquality$Ozone
    x <- na.omit(x)
    bins <- seq(min(x), max(x), length.out = input$bins +1)
    
    hist(x, breaks=bins, col="#dd1c77", border="black",
         xlab = "Ozone level",
         main="Histogram of Ozone level")
  }
    
  )
}

# Create Shiny app
shinyApp(ui = ui, server = server)