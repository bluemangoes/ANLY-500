#

# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
class(Orange)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
  titlePanel("Age/Circumferece by Tree"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput("data","Tree",
                    sort(as.numeric(unique(Orange$Tree)),

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("dataset")
      )
   ))
)),

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
  
  input$dataset <- Orange$Tree
  output$dataset <- renderPlot({
    
    barplot(Orange$age, Orange$circumference, xlab="Age (days)", ylab="Circumference (mm)")}
    
    )}),

# Run the application 
shinyApp(ui = ui, server = server)

