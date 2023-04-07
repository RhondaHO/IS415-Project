library(shiny)

# for each tabPanel, can add fluidPage() to add content


ui <- 
navbarPage("the right space", 
           collapsible = TRUE,
tabPanel("Home",),
tabPanel("EDA",
         fluidPage(
           tabsetPanel(
             tabPanel("x"),
             tabPanel("Chloropleth Mapping"),
             tabPanel("Attending Workshops")
             ))),
tabPanel("Spatial Point Pattern Analysis",
         fluidPage(
           tabsetPanel(
             tabPanel("CLQ"),
             tabPanel("KDE"),
             tabPanel("F-Function"),
             tabPanel("Ripley (K-Function)"),
             tabPanel("Network Constraint Analysis", fluidPage(
               titlePanel("Hello Shiny!"),
               sidebarLayout(
                 sidebarPanel(
                   sliderInput("obs", "Observations:", min = 0, max = 1000, value = 500)
                 ),
                 mainPanel(
                   plotOutput("distPlot")
                 )
               )
             ))
             ))), 
tabPanel("Dataset",
         fluidPage(
           
         )),
tabPanel("Data Upload",
         fluidPage(
           fileInput("upload", "Upload a file")
           #https://mastering-shiny.org/action-transfer.html
         ))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
}

# Run the application 
shinyApp(ui = ui, server = server)
