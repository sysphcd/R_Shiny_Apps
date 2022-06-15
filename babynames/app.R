library(shiny)
library(tidyverse)
library(babynames)


ui <- fluidPage(titlePanel("Baby name trend"),
                textInput(inputId="baby_name", label = "Name : ", placeholder = "Enter the baby name", value=""),
                selectInput(inputId = "baby_gender", label = "Gender :", choices =  c("Male" = "M",
                                                                                      "Female" = "F")),
                sliderInput(inputId = "year", 
                            label = "Year Range:", 
                            min = min(babynames$year), 
                            max=max(babynames$year), 
                            value=c(min(babynames$year),
                                  max(babynames$year)), 
                            sep=""),
                submitButton(text="Create the plot"),
                plotOutput(outputId = "nameplot")
)

server <-function(input, output) {
  
  output$nameplot <- renderPlot(
    babynames %>%
      filter(sex ==input$baby_gender, 
             name== input$baby_name) %>%
      ggplot(aes(x=year, y=n)) +
      geom_line() + 
      scale_x_continuous(limits=input$year)+
      theme_minimal()
  )
  
  
}

shinyApp(ui=ui, server=server)