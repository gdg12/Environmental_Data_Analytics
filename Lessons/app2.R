library(shiny)
library(ggplot2)
install.packages(rsconnect)
install.packages('rsconnect')
# ui
ui <- fluidPage(
   
   # title
   titlePanel('normal distribution'),
   # normal distribution formula
   headerPanel(withMathJax('$$f(x) = \\frac{1}{\\sigma\\sqrt{2\\pi}} e^\\frac{-(x-\\mu)^{2}}{2\\sigma^2}$$')), 
   ###The withmathjax allows you to have math talk within the shiny app
   
   
   # sidebar with slider and checkbox inputs. We have 5 different inputs: 3 slider inputs and 2 checkbox inputs. 
   sidebarLayout(
      sidebarPanel(
         sliderInput('n',
                     'sample size',
                     min = 0,
                     max = 500,
                     value = 100),
         sliderInput('mu',
                     withMathJax('$$\\mu$$'), 
                     min = -5,
                     max = 5,
                     value = 0,
                     step = 0.1),
         sliderInput('sigma', 
                     withMathJax('$$\\sigma$$'),
                     min = 0.01,
                     max = 10,
                     value = 5,
                     step = 0.1),
         checkboxInput('histogram', label = 'histogram', value = TRUE), 
         checkboxInput('density', label = 'density', value = TRUE)
      ),
      
      # main plot
      mainPanel(
         plotOutput('dist')
      )
   )
)

# server
###Always start server with function(input, output){
server <- function(input, output) {
  
###Output plot
   output$dist <- renderPlot({ # adjust the number of bins based on the sample size
     
     n <- input$n
     if(n < 25){
       bins <- 10  #Taylor designated bins to be based off of his sample size n. Less than n=25 sample size, give me 10 bins
     } else if(n < 50){
       bins <- 20
     } else if(n <= 500){
       bins <- 30
     }
     
     set.seed(1001) # prevent output from changing based on plot type
     ###That way, even if plot type is changed, the output will be same

      x <- rnorm(input$n, input$mu, input$sigma) # determine distribution 
      
      # draw the histogram with the specified number of bins
      
      ###If histogram has been checked, take basic plot and add a histogram with x and y being the density of this plot
      ###If density is checked, then take basic plot and add the density PDF to it
     p <- ggplot() + scale_x_continuous(limits = c(-20, 20))
     if(input$histogram) p <- p + geom_histogram(aes(x, y = ..density..), bins = bins, colour = 'black', fill = 'white') # add hist if checked
     if(input$density) p <- p + geom_density(aes(x), alpha=.2, fill="#FF6666") # add density if checked
     p + theme_minimal()
   })
}

# run application with this line of code
shinyApp(ui = ui, server = server)



