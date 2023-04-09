#load packages
pacman::p_load(shiny,readxl, sf, tidyverse, tmap, sfdep,  ggpubr, plotly, sfdep, data.table, leaflet, shinyjs, shinyWidgets)
#library(shinythemes)

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
# based on visualisations, realised an area is placed wrongly (api gave wrong coordinates, thus, i removed it)
resale_sf_map<- subset(resale_sf, full_address != "BLK 27 MARINE CRES")

# for each tabPanel, can add fluidPage() to add content
ui <- 
navbarPage("the right space", 
           collapsible = TRUE,
tabPanel("Home",
         fluidPage(
           setBackgroundColor("ghostwhite")
           
         )
         
         ),
tabPanel("Visualisation",
         fluidPage(
           titlePanel("Mapping of HDB Locations and Relevant Amenities"),
           
           sidebarLayout(position = "right",
                         sidebarPanel(
                           p(id="","In this panel, you can adjust the visualisation of HDB locations with different amenities and adjust the price range of the HDB flat."),
                           selectInput("dataset_map", "What would like to view:",
                                       choices = c("Overview of HDB Locations", "HDB and Supermarkets")),
                           selectInput("price_range", "HDB Price Range:",
                                       choices = c("All","200,000 to 400,000", "400,000 to 600,000"))
                           #numericInput("price", "Observations:", 10)
                         ),
                         mainPanel(
                           
                           leafletOutput("map"),
                           p(id="note","Note: The map will take a while to load."),
                           
                           
                          )
                         )
             )
         ), #end bracket for visualisation tab
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


# Define server logic
server <- function(input, output) {
  
  delay(3000, hide("note"))
  
  m <- tm_shape(mpsz_sf) +
    tm_polygons("REGION_N", alpha = 0.2) +
    tm_shape(resale_sf_map) +
    tm_dots(col = "resale_price", 
            id = "full_address", 
            popup.vars = c("Resale Price:" = "resale_price",
                           "Flat Type:" = "flat_type", 
                           "Flat Model:" = "flat_model",
                           "Floor Area (sqm):" = "floor_area_sqm",
                           "Remaining Lease:" = "remaining_lease"
            ),
            title = "Resale Prices") +
    tm_view(set.zoom.limits = c(10, 14))
 
  # Convert tmap object to leaflet object
  leaflet_map <- tmap_leaflet(m)
  
  # Render leaflet map
  output$map <- renderLeaflet(leaflet_map)
}


# Run the application 
shinyApp(ui = ui, server = server)
