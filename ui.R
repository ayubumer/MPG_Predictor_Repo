
library(shiny)

# Define UI for application for MPG Predictor
shinyUI(fluidPage(
  
  # Application title
  titlePanel("MPG Predictor"),
  
  
  # Sidebar with a slider input  
  sidebarLayout(
    sidebarPanel(
       sliderInput("Cyl",
                   "Number of Cyl:",
                   min = 1,
                   max = 8,
                   value = 4),
       
       sliderInput(
               "Gears",
               "Number of Gears",
               min = 3,
               max = 8,
               value = 4),
       
       selectInput("Trans",
                   "Type of Transmission",
                   c("AT","MT"),
                   selected = "AT",
                   multiple = FALSE
                   ),
       
       selectInput(
               "Hp",
               "Horse Power",
               unique(mtcars$hp[order(mtcars$hp)]),
               selected = "150",
               multiple = FALSE
                    )
       
       
    ),
    
    # Show a output of the predicted MPG and list of cars
    mainPanel(
           
            h3("MPG Prediction"),
            textOutput("prediction"),
            h3("List of Cars for Specified Criteria"),
            textOutput("cars"),
            h3("Instructions : "),
            h4("-Use Sliders to adjust the values of Cylinder and Gears."),
            h4("-Select the values for Trasmission."),
            h4("-AT for Automatic and MT for Manual Tranmission."),
            h4("-Select aprox or Nearest horse Power give system the HP"),
            h4("-The Prediction for MPG will Appear"),
            h3("Disclaimer : "),
            h4("This MPG predictor is based on data from R mtcars.")
                  )
    
    
  )
))
