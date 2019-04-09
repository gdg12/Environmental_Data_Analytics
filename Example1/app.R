#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
###data<-read.csv()
###Call packages at the beginning, and read in data

# Define UI for application that draws a histogram
###The UI defines what page will look like to the user

###Input('name of object','label )
ui <- fluidPage(      ###Always start with fluidPage
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(        
         sliderInput("bins",  ##"bins" is actual object name, "Number of Bins" is what the user sees
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)   ###Set first possible value as 30
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")  ###Call
      )
   )
)

# Define server logic required to draw a histogram

server <- function(input, output) {
   
  ###Always need some sort of render function-->renderplot, rendertable, rendertext, etc. In this case, we want a histogram so use renderplot
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1) ##Add 1 to whatever value user specifies-->that way the lowest # of bins you could have is 1
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}


# Run the application -->ALWAYS have this shinyApp function at the end. 
shinyApp(ui = ui, server = server)

