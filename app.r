library(shiny)
library(shinyWidgets)

my_data <- read.csv(file = "https://raw.githubusercontent.com/admthaqif/child-abuse/master/table_of_child_abuse.csv",
                    stringsAsFactors = TRUE, header = TRUE)
names(my_data)[1] <- ""
my_data<-data.matrix(my_data)

dimnames(my_data) = list(
  c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"),
  c("global","america","africa","europe","oceania","asia")
) # column names

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Give the page a title
  h1(id="big-heading", "Child Abuse from 2013 until 2017",br()),
  tags$style(HTML("#big-heading{color: #961212; font-size: 50px;font-style:italic ; font-size:600%;}")),
  
  setBackgroundImage("https://www.deseretnews.com/images/article/hires/998056/998056.jpg"),
  # Generate a row with a sidebar
  sidebarLayout(
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("region", "Region:",
                  choices=colnames(my_data)),
      hr(),
      helpText("This data is taken from WHO website
               from age 1 until 17 years old")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("phonePlot"),
      plotOutput("phonePlot2")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$phonePlot<- renderPlot({
    
    # Render a barplot
    barplot(my_data[,input$region], 
            main=input$region,
            col=rainbow(17),
            ylab="number of child being abuse (million)",
            xlab="age")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

