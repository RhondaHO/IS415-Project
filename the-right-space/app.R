#load packages
pacman::p_load(shiny,readxl, sf, tidyverse, tmap, sfdep,  ggpubr, plotly, sfdep, data.table, leaflet, shinyjs, shinyWidgets, bslib, raster, spatstat)
#library(shinythemes)

#---------------------------------------- MAIN DATA IMPORTATION
resale_sf<-readRDS("data/rds/resale_sf.rds")
mpsz_sf<-readRDS("data/rds/mpsz_sf.rds")

#---------------------------------------- NETWORK ANALYSIS DATA IMPORTATION
area_names <- c("MARINE PARADE", "BUKIT MERAH", "QUEENSTOWN","OUTRAM", "ROCHOR", "KALLANG","TANGLIN", "CLEMENTI", "BEDOK", "JURONG EAST", "GEYLANG", "BUKIT TIMAH","NOVENA", "TOA PAYOH","TUAS", "JURONG WEST","SERANGOON", "BISHAN","TAMPINES", "BUKIT BATOK","HOUGANG", "ANG MO KIO","PASIR RIS", "BUKIT PANJANG", "YISHUN", "PUNGGOL","CHOA CHU KANG", "SENGKANG","SEMBAWANG", "WOODLANDS")
area_names <- gsub(" ", "_", area_names)

setwd("data/rds/shape")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}

setwd("../facilities/combined/childcare")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}
setwd("../../../lixel/childcare")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}

setwd("../../facilities/combined/eldercare")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}
setwd("../../../lixel/eldercare")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}

setwd("../../facilities/combined/hawker_new")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}
setwd("../../../lixel/hawker_new")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}

setwd("../../facilities/combined/gym")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}
setwd("../../../lixel/gym")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}

setwd("../../facilities/combined/hdb_carpark")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}
setwd("../../../lixel/hdb_carpark")
files <- list.files(pattern = ".rds")
for (file in files) {
  df_name <- sub(".rds", "", file)
  assign(df_name, readRDS(file))
}

# setwd("../../kfunc/childcare/multi")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

#theme
my_theme <- bs_theme(
  version = 5,
  bootswatch = "minty",
  #navbar_color = "#5cb85c"
)

#UI
ui <- 
navbarPage(img(src="logo_t.png", style="float:right", width = "190px", height = "55px",),
  #"the right space", 
           collapsible = TRUE,
  #### HOME ####
tabPanel("Home",
         fluidPage(
           theme = my_theme,
           #titlePanel("Enhancing HDB Buyer Decision-making: Spatial Point Pattern Analysis of Locations and Amenities"),
           
           # main with project description and motivation
           sidebarLayout(
             position = "right",
             sidebarPanel(
               div(style = "text-align: center;",
                   fluidRow(
                     column(6,  img(src='logo_t.png', align = "center", width = "190px", height = "55px", style = "display: block; margin: auto;")),
                     column(6, img(src='smu.png', align = "center", width = "130px", height = "55px", style = "display: block; margin: auto;"))
                   ),
                  
                   h6("Authors"),
                   p("This project is done by G1T7, Nguyen Mai Phuong, Kwang Kai Xuan Belle and Rhonda Ho Kah Yee"),
                   
                   h6("Acknowledgements"),
                   p("This project is done for IS415  Geospatial Analytics and Applications and we would like to thank Professor Kam Tin Seong for his guidance and resources."),
               ),
               #img(src='logo.PNG', align = "right"),
               
             ),
             
             # Main panel with analysis
             mainPanel(
               tags$head(
                 tags$style(
                   HTML("
        p {
          text-align: justify;
          text-justify: inter-word;
        }
      ")
                 )
               ),
               h2("Enhancing HDB Buyer Decision-making: Spatial Point Pattern Analysis of Locations and Amenities"),
               br(),
               img(src='istockphoto-466725040-170667a.jpg',width = "500px", height = "300px", align = "center", style = "display: block; margin: auto;"),
               h3("Our Motivation"),
               p("Many prospective HDB buyers face challenges in visualising and understanding the amenities and facilities available in the vicinity of their desired location. They often resort to manual searches on platforms like Google, which can be time-consuming and frustrating. Moreover, current mapping tools do not offer a comprehensive and tailored view of amenities specific to HDBs. Our motivation is to simplify this process by providing a user-friendly analytical app that enables HDB buyers to view and understand the surrounding amenities easily. Our app utilizes advanced spatial point pattern analysis techniques to visualize the distribution and clustering of amenities relevant to HDB buyers. By providing a customized view of amenities that cater specifically to the needs of HDB buyers, we aim to empower HDB buyers to make more informed decisions about their purchases and feel more confident in their chosen residence."),
               
               #h3("Our Objectives"),
               #p(" We aim to perform the following objectives:"),
               #p("1. Estimate the intensity of HDB locations and amenities across the study area using Kernel Density Estimation. 2. Determine whether the distribution of amenities around HDBs is random or clustered, and calculate the ratio of observed to expected nearest neighbor distances using F-Function analysis.
 #Measure the degree of clustering or dispersion of HDB locations and surrounding amenities using Ripley's K-function and L-function analysis.
 #Quantify the extent of spatial association and heterogeneity between HDB locations and surrounding amenities using Colocation Quotients (CLQs) analysis.
 #Conduct Network Constrained Spatial Point Patterns Analysis to analyze the spatial distribution of HDB flats over a street network.

#Overall, we aim to simplify the process for HDB buyers by providing them with a user-friendly app that visualizes the amenities and facilities in their desired location. By utilizing advanced spatial point pattern analysis techniques, we will identify significant spatial patterns and trends to help buyers make more informed decisions about their purchases and feel more confident in their chosen residence. Furthermore, the insights we gain will inform planning and policy decisions related to urban development and resource allocation.")
             )
           )
           
         )
         
         ),
#---------------------------------------- VISUALISATION
#### Visualisation ####
tabPanel("Visualisation",
         fluidPage(
           #setBackgroundColor("#F5F5F5"),
           
           titlePanel("Mapping of HDB Locations and Relevant Amenities"),
           p(id="note","Note: Please wait a while for the map to load."),
           sidebarLayout(position = "right",
                         
                         sidebarPanel(
                           h4("Description"),
                           p(id="","In this panel, you can adjust the visualisation of HDB locations(yellow/orange dots) with different amenities(light blue dots) and adjust the price range of the HDB flat."),
                           selectInput("HDB_amenities", label=h4("What would like to view:"),
                                       choices = c("Overview of HDB Locations",
                                                  "Childcare Centres" = "childcare_sf",
                                                   "Eldercare Centres" = "eldercare_sf",
                                                   "Kindergartens" = "kindergartens_sf",
                                                   "Hawkercentres" = "hawkercentre_new_sf",
                                                   "Healthier Hawkercentres" = "hawkercentre_healthy_sf",
                                                   "National Parks" = "nationalparks_sf",
                                                   "Gyms" = "gyms_sf",
                                                   "Retail Pharmacy" = "pharmacy_sf",
                                                   "SPF" = "spf_sf",
                                                   "Carparks" = "carpark_sf",
                                                   "Supermarkets" = "supermarket_sf",
                                                   "Bus stops" = "bus_stop_sf",
                                                   "Mrt" = "mrt_sf",
                                                   "Primary Schools" = "primary_school_sf",
                                                   "Shopping Malls" = "shopping_mall_sf"
                                                   ), 
                                       selected="Overview of HDB Locations"),
                           
                           selectInput("resale_range", label=h4("HDB Price Range($):"),
                                       choices = c("All","200,000 to 400,000", 
                                                   "400,000 to 600,000",
                                                   "600,000 to 800,000","800,000 to 1,000,000",
                                                   "1,000,000 to 1,200,000",
                                                   "1,200,000 to 1,400,000",
                                                   "1,400,000 to 1,600,000"),
                                       selected = "All",
                                       #multiple = TRUE
                                       )
                           #numericInput("price", "Observations:", 10)
                         ),
                         mainPanel(
                           leafletOutput("map"),
                          )
                         )
             )
         ), #end bracket for visualisation tab

#---------------------------------------- SPATIAL POINT
#### Spatialpoint ####
tabPanel("Spatial Point Pattern Analysis",

         fluidPage(
           fluidRow(
             column(width = 4,
                    titlePanel("Spatial Point Pattern Analysis"),
             ),
             column(width = 8, style = "margin-top: 25px;",
                    useShinyjs(),
                    actionButton("toggle", "More Info"),
             )
           ),
           div(
             id = "tools_div",
             style = "width: 90%; display: none;",
             p("On this page, we offer several tools designed to help you analyze the spatial distribution of points in your dataset. Our tools includes the Local Colocation Quotient Analysis (CLQ), Kernel Density Estimation (KDE), F-Function, Ripley K-Function, and Network Constraint Analysis. To access these tools, simply click on the five tabs located at the top of the page. Each tool provides a unique perspective on the spatial patterns in your data, allowing you to gain valuable insights into the underlying processes driving your observations. Whether you seek to comprehend the level of clustering present in your dataset, identify spatial patterns, or investigate the influence of network constraints on your observations, our toolkit offers a range of analytical tools to cater to your needs.")
           ),
           #### Tabset CLQ ####
           tabsetPanel(
             tabPanel("CLQ", fluidPage(
               #p(id="note","Note: Please wait a while for the map to load."),
               sidebarLayout(position = "right",
                 sidebarPanel(
                   h4("Description"),
                   p("Take note that the map may take some time to load. The map will display the Childcare Centres CLQ by default when the page loads."),
                  p("Please select the type of amenities you are interested in viewing the CLQ values."),
                   selectInput("clq_amenities", label = h4("Amenity Type"), 
                               choices = c("Childcare Centres" = "HDB_Childcare",
                                           "Eldercare Centres" = "HDB_Eldercare",
                                           "Kindergartens" = "HDB_Kindegarten",
                                           "Hawkercentres" = "HDB_Hawker",
                                           #"Healthier Hawkercentres" = "hawkercentre_healthy_sf",
                                           "National Parks" = "HDB_NationalParks",
                                           "Gyms" = "HDB_Gym",
                                           "Retail Pharmacy" = "HDB_Pharmacy",
                                           #"SPF" = "spf_sf",
                                           "Carparks" = "HDB_Carparks",
                                           "Supermarkets" = "HDB_Supermarket",
                                           "Bus stops" = "HDB_Bus",
                                           "Mrt" = "HDB_Mrt",
                                           "Primary Schools" = "HDB_PrimarySchool",
                                           "Shopping Malls" = "HDB_ShoppingMall"
                               ) 
                               #selected = "ANG_MO_KIO"
                               ),
                   h4("Intepretation"),
                   p("XXX")
                 ),
                 mainPanel(
                   leafletOutput("clq_outputmap"),
                   #p(id="note","Note: The map will take a while to load."),
                 )
               )
             )),
             #end of clq
             
           #### Tabset KDE ####
             tabPanel("KDE",
                      fluidPage(
               sidebarLayout(position = "right",
                             sidebarPanel(
                               h4("Description"),
                               p("Please first select the type of KDE Amenity graph, the bandwidth, and the kernel from the dropdown menus, and then click the 'Visualize KDE Graph' button. Take note that generating the graph may take some time."),
                               selectInput("kde_amenity", label = h4("Amenity Type"), 
                                           choices = c("HDB",
                                                       "Childcare Centres",
                                                       "Eldercare Centres",
                                                       "Kindergartens",
                                                       "Hawkercentres",
                                                       "Healthier Hawkercentres",
                                                       "National Parks",
                                                       "Gyms",
                                                       "Retail Pharmacy",
                                                       "SPF",
                                                       "Carparks",
                                                       "Supermarkets",
                                                       "Bus stops",
                                                       "Mrt",
                                                       "Primary Schools",
                                                       "Shopping Malls"
                                           ), selected="HDB"
                                           ),
                               selectInput("kde_bw", label = h4("Bandwith"), 
                                           choices = c("bw.diggle",
                                                       "bw.ppl",
                                                       "bw.CvL",
                                                       "bw.scott"), 
                                           ),
                               selectInput("kde_kernel", label = h4("Kernel"), 
                                           choices = c("Gaussian" = "gaussian",
                                                       "Epanechnikov" ="epanechnikov",
                                                       "Quartic" = "quartic",
                                                       "Disc" ="disc"), 
                                           ),
                               
                               actionButton("run_kde", "Visualise KDE graph")
                             ),
                             mainPanel(
                               plotOutput("kde_plot")
                             )
               )
             )),
             #end of KDE
             
             tabPanel("F-Function", fluidPage(
               sidebarLayout(position = "right",
                             sidebarPanel(
                               h4("Variables"),
                               selectInput("net_areaName", label = h4("Area Name"), 
                                           choices = area_names, 
                                           selected = "ANG_MO_KIO"),
                             ),
                             mainPanel(
                               #plotOutput("XX")
                             )
               )
             )),
             
             #end of F-function
           ####RIPLEY####
             tabPanel("Ripley (K-Function)"),
           
           
           ####NETWORK ####
             tabPanel("Network Constraint Analysis", fluidPage(
               sidebarLayout(
                 sidebarPanel(
                   h2("Variables"),
                   selectInput("net_areaName", label = h4("Area Name"), 
                               choices = area_names, 
                               selected = "ANG_MO_KIO"),
                   selectInput("net_facility", label = h4("Area Name"), 
                               choices = list("Childcare" = "childcare",
                                              "Eldercare" = "eldercare",
                                              "New Hawkers" = "hawker_new",
                                              "Gym" = "gym",
                                              "HDB Carparks" = "carpark"), 
                               selected = "Childcare"),
                 ),
                 mainPanel(
                   plotOutput("networkLixel"),
                   plotOutput("networkKFunc")
                 )
               )
             ))
             ))), 
#tabPanel("Dataset",
#         fluidPage(
           
#         )),
tabPanel("Data Upload",
         fluidPage(
           fileInput("upload", "Upload a file")
           #https://mastering-shiny.org/action-transfer.html
         ))
)

#### Define server logic ####
server <- function(input, output) {
  delay(3000, hide("note")) #delay function
  observeEvent(input$toggle, {
    toggle("tools_div")
  })
  
  
  #### Visualisations ####
  observeEvent(c(input$resale_range,input$HDB_amenities), {
    #filter dataset for map
    if (input$resale_range!= "All"){
      resale_map <- resale_sf[resale_sf$resale_range == input$resale_range, ]
    }else{
      resale_map <-resale_sf
    }
    
    if (input$HDB_amenities!= "Overview of HDB Locations"){
      result <- readRDS(paste0("data/rds/",input$HDB_amenities, ".rds"))
      
      m <- tm_shape(mpsz_sf) +
        tm_polygons("REGION_N",
                    alpha = 0.2) +
        tm_shape(resale_map) +
        tm_dots(col = "resale_price", 
                id = "full_address", # bold in popup
                popup.vars = c("Resale Price:" = "resale_price",
                               "Flat Type:" = "flat_type", 
                               "Flat Model:" = "flat_model",
                               "Floor Area (sqm):" = "floor_area_sqm",
                               "Remaining Lease:" = "remaining_lease"
                ),
                title = "Resale Prices") +
        tm_shape(result) +
        tm_dots(
                #alpha=0.2,
                col="#78cce4",
                size=0.03) +
        tm_view(set.zoom.limits = c(10, 14))
      
    }else{
      m <- tm_shape(mpsz_sf) +
        tm_polygons("REGION_N", alpha = 0.2) +
        tm_shape(resale_map) +
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
    }
    
  
    # Convert tmap object to leaflet object
    leaflet_map <- tmap_leaflet(m)
    # Render leaflet map
    output$map <- renderLeaflet(leaflet_map)
  })
  #----- END VISUALISATIONS
  
  #### CLQ ####
  observeEvent(input$clq_amenities, {
    result <- readRDS(paste0("data/rds/clq/",input$clq_amenities, ".rds"))
    
    amenity_name <- names(result)[2]
    amenity_pvalue <- names(result)[3]
  
    clq_map <- tm_shape(mpsz_sf) +
      tm_polygons() +
      tm_shape(result, subset = result$amenity_pvalue < 0.05) + #filter out p_value less than 0.05 
      tm_dots(col = amenity_name,
              size = 0.01,
              border.col = "black",
              border.lwd = 0.5) +
      tm_view(set.zoom.limits = c(11, 14))
     
    output$clq_outputmap <- renderLeaflet(tmap_leaflet(clq_map))
    })

  #### KDE ####
  kde_files <- c("HDB" = "hdbSG_ppp.km",
                 "Childcare Centres" = "childcareSG_ppp.km",
                 "Eldercare Centres" = "eldercareSG_ppp.km",
                 "Kindergartens" = "kindergartensSG_ppp.km",
                 "Hawkercentres" = "hawkercentre_newSG_ppp.km",
                 "Healthier Hawkercentres" = "hawkercentre_healthySG_ppp.km",
                 "National Parks" = "nationalparksSG_ppp.km",
                 "Gyms" = "gymsSG_ppp.km",
                 "Retail Pharmacy" = "pharmacySG_ppp.km",
                 "SPF" = "spfSG_ppp.km",
                 "Carparks" = "carparkSG_ppp.km",
                 "Supermarkets" = "supermarketSG_ppp.km",
                 "Bus stops" = "bus_stopSG_ppp.km",
                 "Mrt" = "mrtSG_ppp.km",
                 "Primary Schools" = "primary_schoolSG_ppp.km",
                 "Shopping Malls" = "shopping_mallSG_ppp.km")

      observeEvent(input$run_kde,{
        
        index_kde <- match(input$kde_amenity, names(kde_files))
        kde_name <- kde_files[index_kde]
        kde_rds <- readRDS(paste0("data/rds/kde/",kde_name,".rds"))
        
        
        # Calculate kernel density estimate
        kde_result <- density(kde_rds, 
                              sigma = get(input$kde_bw), 
                              edge = TRUE, 
                              kernel = input$kde_kernel)
        
        # Render plot
        output$kde_plot <- renderPlot({
          plot(kde_result)
        })
      })

  #----- END KDE
  
  #----- START Ffunction
  #----- END Ffunction
  
  
  #NETWORK ANALYSIS
  output$networkLixel <- renderPlot(
    tm_shape(get(paste0("shape_", input$net_areaName))) +
      tm_polygons() +
      tm_shape(get(paste0("lixel_",input$net_facility, "_", input$net_areaName)))+
      tm_lines(col="density", lwd=2)+
      tm_shape(get(paste0("hdb_",input$net_facility, "_", input$net_areaName)))+
      tm_dots(col = "Point Type", palette=c('blue', 'red'))
  )
  # output$networkKFunc <- renderPlot(
  #   get(paste0("kfunc_", input$net_facility, "_", input$net_areaName))$plotk
  # )
}


# Run the application 
shinyApp(ui = ui, server = server)
