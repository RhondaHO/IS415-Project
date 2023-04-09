pacman::p_load(shiny,readxl, sf, tidyverse, tmap, sfdep,  ggpubr, plotly, sfdep, data.table)
# for each tabPanel, can add fluidPage() to add content

# import data
resale_sf<-readRDS("data/rds/resale_sf.rds")
mpsz_sf<-readRDS("data/rds/mpsz_sf.rds")

childcare_sf <- readRDS("data/rds/childcare_sf.rds")
eldercare_sf<- readRDS("data/rds/eldercare_sf.rds")
kindergartens_sf <- readRDS("data/rds/kindergartens_sf.rds")
hawkercentre_new_sf <- readRDS("data/rds/hawkercentre_new_sf.rds")
hawkercentre_healthy_sf<-readRDS("data/rds/hawkercentre_healthy_sf.rds")
nationalparks_sf<-readRDS("data/rds/nationalparks_sf.rds")
gyms_sf <-readRDS("data/rds/gyms_sf.rds")
pharmacy_sf<-readRDS("data/rds/pharmacy_sf.rds")
spf_sf<-readRDS("data/rds/spf_sf.rds")
HDB_carpark_sf<-readRDS("data/rds/HDB_carpark_sf.rds")
supermarket_sf<-readRDS("data/rds/supermarket_sf.rds")
bus_stop_sf<-readRDS("data/rds/bus_stop_sf.rds")
mrt_sf<-readRDS("data/rds/mrt_sf.rds")
primary_school_sf<-readRDS("data/rds/primary_school_sf.rds")
top10_primary_school_sf<-readRDS("data/rds/top10_primary_school_sf.rds")
shopping_mall_sf<-readRDS("data/rds/shopping_mall_sf.rds")
# combine street name and blk for HDB full address
resale_sf$full_address <- paste("BLK", resale_sf$block, resale_sf$street_name)

ui <- 
navbarPage("the right space", 
           collapsible = TRUE,
tabPanel("Home",),
tabPanel("Visualisation",
         fluidPage(
           #leafletOutput("map")
             )),
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
#server <- function(input, output) {
#}

# Define server logic
server <- function(input, output) {
  
 
  
}


# Run the application 
shinyApp(ui = ui, server = server)
