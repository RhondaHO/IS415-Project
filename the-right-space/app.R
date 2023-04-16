#install.packages("dplyr")
#install.packages("vctrs")

#load packages
pacman::p_load(dplyr, shiny,readxl, sf, tmap, sfdep,  ggpubr, 
               plotly, data.table, leaflet, shinyjs, shinyWidgets, bslib, 
               raster, spatstat, olsrr, ggplot2, ggthemes, rvest, httr, jsonlite, maptools, vctrs)

#library(shinythemes)

#---------------------------------------- MAIN DATA IMPORTATION
resale_sf<-readRDS("data/rds/resale_sf.rds")
mpsz_sf<-readRDS("data/rds/mpsz_sf.rds")
mpsz <- readRDS("data/rds/mpsz.rds")
resale_ppp_jit <- readRDS("data/rds/resale_ppp_jit.rds")


#---------------------------------------- NETWORK ANALYSIS DATA IMPORTATION
area_names_1 <- c("MARINE PARADE", "BUKIT MERAH", "QUEENSTOWN","OUTRAM", "ROCHOR", "KALLANG","TANGLIN", "CLEMENTI", "BEDOK", "JURONG EAST", "GEYLANG", "BUKIT TIMAH","NOVENA", "TOA PAYOH","TUAS", "JURONG WEST","SERANGOON", "BISHAN","TAMPINES", "BUKIT BATOK","HOUGANG", "ANG MO KIO","PASIR RIS", "BUKIT PANJANG", "YISHUN", "PUNGGOL","CHOA CHU KANG", "SENGKANG","SEMBAWANG", "WOODLANDS")
area_names <- gsub(" ", "_", area_names_1)

# setwd("data/rds/shape")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

shape_ANG_MO_KIO <- readRDS("data/rds/shape/shape_ANG_MO_KIO.rds")
shape_BEDOK <- readRDS("data/rds/shape/shape_BEDOK.rds")
shape_BISHAN <- readRDS("data/rds/shape/shape_BISHAN.rds")
shape_BUKIT_BATOK <- readRDS("data/rds/shape/shape_BUKIT_BATOK.rds")
shape_BUKIT_MERAH <- readRDS("data/rds/shape/shape_BUKIT_MERAH.rds")
shape_BUKIT_PANJANG <- readRDS("data/rds/shape/shape_BUKIT_PANJANG.rds")
shape_BUKIT_TIMAH <- readRDS("data/rds/shape/shape_BUKIT_TIMAH.rds")
shape_CHOA_CHU_KANG <- readRDS("data/rds/shape/shape_CHOA_CHU_KANG.rds")
shape_CLEMENTI <- readRDS("data/rds/shape/shape_CLEMENTI.rds")
shape_GEYLANG <- readRDS("data/rds/shape/shape_GEYLANG.rds")
shape_HOUGANG <- readRDS("data/rds/shape/shape_HOUGANG.rds")
shape_JURONG_EAST <- readRDS("data/rds/shape/shape_JURONG_EAST.rds")
shape_JURONG_WEST <- readRDS("data/rds/shape/shape_JURONG_WEST.rds")
shape_KALLANG <- readRDS("data/rds/shape/shape_KALLANG.rds")
shape_MARINE_PARADE <- readRDS("data/rds/shape/shape_MARINE_PARADE.rds")
shape_NOVENA <- readRDS("data/rds/shape/shape_NOVENA.rds")
shape_OUTRAM <- readRDS("data/rds/shape/shape_OUTRAM.rds")
shape_PASIR_RIS <- readRDS("data/rds/shape/shape_PASIR_RIS.rds")
shape_PUNGGOL <- readRDS("data/rds/shape/shape_PUNGGOL.rds")
shape_QUEENSTOWN <- readRDS("data/rds/shape/shape_QUEENSTOWN.rds")
shape_ROCHOR <- readRDS("data/rds/shape/shape_ROCHOR.rds")
shape_SEMBAWANG <- readRDS("data/rds/shape/shape_SEMBAWANG.rds")
shape_SENGKANG <- readRDS("data/rds/shape/shape_SENGKANG.rds")
shape_SERANGOON <- readRDS("data/rds/shape/shape_SERANGOON.rds")
shape_TAMPINES <- readRDS("data/rds/shape/shape_TAMPINES.rds")
shape_TANGLIN <- readRDS("data/rds/shape/shape_TANGLIN.rds")
shape_TOA_PAYOH <- readRDS("data/rds/shape/shape_TOA_PAYOH.rds")
shape_TUAS <- readRDS("data/rds/shape/shape_TUAS.rds")
shape_WOODLANDS <- readRDS("data/rds/shape/shape_WOODLANDS.rds")
shape_YISHUN <- readRDS("data/rds/shape/shape_YISHUN.rds")

# setwd("../facilities/combined/childcare")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

hdb_childcare_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_ANG_MO_KIO.rds")
hdb_childcare_BEDOK <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_BEDOK.rds")
hdb_childcare_BISHAN <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_BISHAN.rds")
hdb_childcare_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_BUKIT_BATOK.rds")
hdb_childcare_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_BUKIT_MERAH.rds")
hdb_childcare_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_BUKIT_PANJANG.rds")
hdb_childcare_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_BUKIT_TIMAH.rds")
hdb_childcare_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_CHOA_CHU_KANG.rds")
hdb_childcare_CLEMENTI <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_CLEMENTI.rds")
hdb_childcare_GEYLANG <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_GEYLANG.rds")
hdb_childcare_HOUGANG <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_HOUGANG.rds")
hdb_childcare_JURONG_EAST <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_JURONG_EAST.rds")
hdb_childcare_JURONG_WEST <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_JURONG_WEST.rds")
hdb_childcare_KALLANG <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_KALLANG.rds")
hdb_childcare_MARINE_PARADE <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_MARINE_PARADE.rds")
hdb_childcare_NOVENA <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_NOVENA.rds")
hdb_childcare_OUTRAM <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_OUTRAM.rds")
hdb_childcare_PASIR_RIS <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_PASIR_RIS.rds")
hdb_childcare_PUNGGOL <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_PUNGGOL.rds")
hdb_childcare_QUEENSTOWN <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_QUEENSTOWN.rds")
hdb_childcare_ROCHOR <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_ROCHOR.rds")
hdb_childcare_SEMBAWANG <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_SEMBAWANG.rds")
hdb_childcare_SENGKANG <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_SENGKANG.rds")
hdb_childcare_SERANGOON <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_SERANGOON.rds")
hdb_childcare_TAMPINES <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_TAMPINES.rds")
hdb_childcare_TANGLIN <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_TANGLIN.rds")
hdb_childcare_TOA_PAYOH <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_TOA_PAYOH.rds")
hdb_childcare_TUAS <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_TUAS.rds")
hdb_childcare_WOODLANDS <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_WOODLANDS.rds")
hdb_childcare_YISHUN <- readRDS("data/rds/facilities/combined/childcare/hdb_childcare_YISHUN.rds")

# setwd("../../../lixel/childcare")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

lixel_childcare_ANG_MO_KIO <- readRDS("data/rds/lixel/childcare/lixel_childcare_ANG_MO_KIO.rds")
lixel_childcare_BEDOK <- readRDS("data/rds/lixel/childcare/lixel_childcare_BEDOK.rds")
lixel_childcare_BISHAN <- readRDS("data/rds/lixel/childcare/lixel_childcare_BISHAN.rds")
lixel_childcare_BUKIT_BATOK <- readRDS("data/rds/lixel/childcare/lixel_childcare_BUKIT_BATOK.rds")
lixel_childcare_BUKIT_MERAH <- readRDS("data/rds/lixel/childcare/lixel_childcare_BUKIT_MERAH.rds")
lixel_childcare_BUKIT_PANJANG <- readRDS("data/rds/lixel/childcare/lixel_childcare_BUKIT_PANJANG.rds")
lixel_childcare_BUKIT_TIMAH <- readRDS("data/rds/lixel/childcare/lixel_childcare_BUKIT_TIMAH.rds")
lixel_childcare_CHOA_CHU_KANG <- readRDS("data/rds/lixel/childcare/lixel_childcare_CHOA_CHU_KANG.rds")
lixel_childcare_CLEMENTI <- readRDS("data/rds/lixel/childcare/lixel_childcare_CLEMENTI.rds")
lixel_childcare_GEYLANG <- readRDS("data/rds/lixel/childcare/lixel_childcare_GEYLANG.rds")
lixel_childcare_HOUGANG <- readRDS("data/rds/lixel/childcare/lixel_childcare_HOUGANG.rds")
lixel_childcare_JURONG_EAST <- readRDS("data/rds/lixel/childcare/lixel_childcare_JURONG_EAST.rds")
lixel_childcare_JURONG_WEST <- readRDS("data/rds/lixel/childcare/lixel_childcare_JURONG_WEST.rds")
lixel_childcare_KALLANG <- readRDS("data/rds/lixel/childcare/lixel_childcare_KALLANG.rds")
lixel_childcare_MARINE_PARADE <- readRDS("data/rds/lixel/childcare/lixel_childcare_MARINE_PARADE.rds")
lixel_childcare_NOVENA <- readRDS("data/rds/lixel/childcare/lixel_childcare_NOVENA.rds")
lixel_childcare_OUTRAM <- readRDS("data/rds/lixel/childcare/lixel_childcare_OUTRAM.rds")
lixel_childcare_PASIR_RIS <- readRDS("data/rds/lixel/childcare/lixel_childcare_PASIR_RIS.rds")
lixel_childcare_PUNGGOL <- readRDS("data/rds/lixel/childcare/lixel_childcare_PUNGGOL.rds")
lixel_childcare_QUEENSTOWN <- readRDS("data/rds/lixel/childcare/lixel_childcare_QUEENSTOWN.rds")
lixel_childcare_ROCHOR <- readRDS("data/rds/lixel/childcare/lixel_childcare_ROCHOR.rds")
lixel_childcare_SEMBAWANG <- readRDS("data/rds/lixel/childcare/lixel_childcare_SEMBAWANG.rds")
lixel_childcare_SENGKANG <- readRDS("data/rds/lixel/childcare/lixel_childcare_SENGKANG.rds")
lixel_childcare_SERANGOON <- readRDS("data/rds/lixel/childcare/lixel_childcare_SERANGOON.rds")
lixel_childcare_TAMPINES <- readRDS("data/rds/lixel/childcare/lixel_childcare_TAMPINES.rds")
lixel_childcare_TANGLIN <- readRDS("data/rds/lixel/childcare/lixel_childcare_TANGLIN.rds")
lixel_childcare_TOA_PAYOH <- readRDS("data/rds/lixel/childcare/lixel_childcare_TOA_PAYOH.rds")
lixel_childcare_TUAS <- readRDS("data/rds/lixel/childcare/lixel_childcare_TUAS.rds")
lixel_childcare_WOODLANDS <- readRDS("data/rds/lixel/childcare/lixel_childcare_WOODLANDS.rds")
lixel_childcare_YISHUN <- readRDS("data/rds/lixel/childcare/lixel_childcare_YISHUN.rds")

# setwd("../../facilities/combined/eldercare")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_eldercare_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_ANG_MO_KIO.rds")
# hdb_eldercare_BEDOK <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_BEDOK.rds")
# hdb_eldercare_BISHAN <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_BISHAN.rds")
# hdb_eldercare_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_BUKIT_BATOK.rds")
# hdb_eldercare_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_BUKIT_MERAH.rds")
# hdb_eldercare_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_BUKIT_PANJANG.rds")
# hdb_eldercare_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_BUKIT_TIMAH.rds")
# hdb_eldercare_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_CHOA_CHU_KANG.rds")
# hdb_eldercare_CLEMENTI <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_CLEMENTI.rds")
# hdb_eldercare_GEYLANG <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_GEYLANG.rds")
# hdb_eldercare_HOUGANG <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_HOUGANG.rds")
# hdb_eldercare_JURONG_EAST <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_JURONG_EAST.rds")
# hdb_eldercare_JURONG_WEST <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_JURONG_WEST.rds")
# hdb_eldercare_KALLANG <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_KALLANG.rds")
# hdb_eldercare_MARINE_PARADE <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_MARINE_PARADE.rds")
# hdb_eldercare_NOVENA <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_NOVENA.rds")
# hdb_eldercare_OUTRAM <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_OUTRAM.rds")
# hdb_eldercare_PASIR_RIS <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_PASIR_RIS.rds")
# hdb_eldercare_PUNGGOL <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_PUNGGOL.rds")
# hdb_eldercare_QUEENSTOWN <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_QUEENSTOWN.rds")
# hdb_eldercare_ROCHOR <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_ROCHOR.rds")
# hdb_eldercare_SEMBAWANG <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_SEMBAWANG.rds")
# hdb_eldercare_SENGKANG <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_SENGKANG.rds")
# hdb_eldercare_SERANGOON <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_SERANGOON.rds")
# hdb_eldercare_TAMPINES <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_TAMPINES.rds")
# hdb_eldercare_TANGLIN <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_TANGLIN.rds")
# hdb_eldercare_TOA_PAYOH <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_TOA_PAYOH.rds")
# hdb_eldercare_TUAS <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_TUAS.rds")
# hdb_eldercare_WOODLANDS <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_WOODLANDS.rds")
# hdb_eldercare_YISHUN <- readRDS("data/rds/facilities/combined/eldercare/hdb_eldercare_YISHUN.rds")

# setwd("../../../lixel/eldercare")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_eldercare_ANG_MO_KIO <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_ANG_MO_KIO.rds")
# lixel_eldercare_BEDOK <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_BEDOK.rds")
# lixel_eldercare_BISHAN <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_BISHAN.rds")
# lixel_eldercare_BUKIT_BATOK <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_BUKIT_BATOK.rds")
# lixel_eldercare_BUKIT_MERAH <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_BUKIT_MERAH.rds")
# lixel_eldercare_BUKIT_PANJANG <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_BUKIT_PANJANG.rds")
# lixel_eldercare_BUKIT_TIMAH <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_BUKIT_TIMAH.rds")
# lixel_eldercare_CHOA_CHU_KANG <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_CHOA_CHU_KANG.rds")
# lixel_eldercare_CLEMENTI <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_CLEMENTI.rds")
# lixel_eldercare_GEYLANG <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_GEYLANG.rds")
# lixel_eldercare_HOUGANG <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_HOUGANG.rds")
# lixel_eldercare_JURONG_EAST <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_JURONG_EAST.rds")
# lixel_eldercare_JURONG_WEST <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_JURONG_WEST.rds")
# lixel_eldercare_KALLANG <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_KALLANG.rds")
# lixel_eldercare_MARINE_PARADE <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_MARINE_PARADE.rds")
# lixel_eldercare_NOVENA <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_NOVENA.rds")
# lixel_eldercare_OUTRAM <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_OUTRAM.rds")
# lixel_eldercare_PASIR_RIS <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_PASIR_RIS.rds")
# lixel_eldercare_PUNGGOL <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_PUNGGOL.rds")
# lixel_eldercare_QUEENSTOWN <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_QUEENSTOWN.rds")
# lixel_eldercare_ROCHOR <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_ROCHOR.rds")
# lixel_eldercare_SEMBAWANG <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_SEMBAWANG.rds")
# lixel_eldercare_SENGKANG <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_SENGKANG.rds")
# lixel_eldercare_SERANGOON <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_SERANGOON.rds")
# lixel_eldercare_TAMPINES <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_TAMPINES.rds")
# lixel_eldercare_TANGLIN <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_TANGLIN.rds")
# lixel_eldercare_TOA_PAYOH <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_TOA_PAYOH.rds")
# lixel_eldercare_TUAS <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_TUAS.rds")
# lixel_eldercare_WOODLANDS <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_WOODLANDS.rds")
# lixel_eldercare_YISHUN <- readRDS("data/rds/lixel/eldercare/lixel_eldercare_YISHUN.rds")

# setwd("../../facilities/combined/pharmacy")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_pharmacy_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_ANG_MO_KIO.rds")
# hdb_pharmacy_BEDOK <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_BEDOK.rds")
# hdb_pharmacy_BISHAN <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_BISHAN.rds")
# hdb_pharmacy_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_BUKIT_BATOK.rds")
# hdb_pharmacy_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_BUKIT_MERAH.rds")
# hdb_pharmacy_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_BUKIT_PANJANG.rds")
# hdb_pharmacy_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_BUKIT_TIMAH.rds")
# hdb_pharmacy_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_CHOA_CHU_KANG.rds")
# hdb_pharmacy_CLEMENTI <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_CLEMENTI.rds")
# hdb_pharmacy_GEYLANG <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_GEYLANG.rds")
# hdb_pharmacy_HOUGANG <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_HOUGANG.rds")
# hdb_pharmacy_JURONG_EAST <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_JURONG_EAST.rds")
# hdb_pharmacy_JURONG_WEST <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_JURONG_WEST.rds")
# hdb_pharmacy_KALLANG <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_KALLANG.rds")
# hdb_pharmacy_MARINE_PARADE <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_MARINE_PARADE.rds")
# hdb_pharmacy_NOVENA <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_NOVENA.rds")
# hdb_pharmacy_OUTRAM <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_OUTRAM.rds")
# hdb_pharmacy_PASIR_RIS <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_PASIR_RIS.rds")
# hdb_pharmacy_PUNGGOL <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_PUNGGOL.rds")
# hdb_pharmacy_QUEENSTOWN <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_QUEENSTOWN.rds")
# hdb_pharmacy_ROCHOR <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_ROCHOR.rds")
# hdb_pharmacy_SEMBAWANG <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_SEMBAWANG.rds")
# hdb_pharmacy_SENGKANG <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_SENGKANG.rds")
# hdb_pharmacy_SERANGOON <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_SERANGOON.rds")
# hdb_pharmacy_TAMPINES <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_TAMPINES.rds")
# hdb_pharmacy_TANGLIN <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_TANGLIN.rds")
# hdb_pharmacy_TOA_PAYOH <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_TOA_PAYOH.rds")
# hdb_pharmacy_TUAS <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_TUAS.rds")
# hdb_pharmacy_WOODLANDS <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_WOODLANDS.rds")
# hdb_pharmacy_YISHUN <- readRDS("data/rds/facilities/combined/pharmacy/hdb_pharmacy_YISHUN.rds")

# setwd("../../../lixel/pharmacy")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_pharmacy_ANG_MO_KIO <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_ANG_MO_KIO.rds")
# lixel_pharmacy_BEDOK <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_BEDOK.rds")
# lixel_pharmacy_BISHAN <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_BISHAN.rds")
# lixel_pharmacy_BUKIT_BATOK <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_BUKIT_BATOK.rds")
# lixel_pharmacy_BUKIT_MERAH <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_BUKIT_MERAH.rds")
# lixel_pharmacy_BUKIT_PANJANG <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_BUKIT_PANJANG.rds")
# lixel_pharmacy_BUKIT_TIMAH <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_BUKIT_TIMAH.rds")
# lixel_pharmacy_CHOA_CHU_KANG <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_CHOA_CHU_KANG.rds")
# lixel_pharmacy_CLEMENTI <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_CLEMENTI.rds")
# lixel_pharmacy_GEYLANG <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_GEYLANG.rds")
# lixel_pharmacy_HOUGANG <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_HOUGANG.rds")
# lixel_pharmacy_JURONG_EAST <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_JURONG_EAST.rds")
# lixel_pharmacy_JURONG_WEST <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_JURONG_WEST.rds")
# lixel_pharmacy_KALLANG <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_KALLANG.rds")
# lixel_pharmacy_MARINE_PARADE <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_MARINE_PARADE.rds")
# lixel_pharmacy_NOVENA <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_NOVENA.rds")
# lixel_pharmacy_OUTRAM <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_OUTRAM.rds")
# lixel_pharmacy_PASIR_RIS <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_PASIR_RIS.rds")
# lixel_pharmacy_PUNGGOL <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_PUNGGOL.rds")
# lixel_pharmacy_QUEENSTOWN <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_QUEENSTOWN.rds")
# lixel_pharmacy_ROCHOR <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_ROCHOR.rds")
# lixel_pharmacy_SEMBAWANG <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_SEMBAWANG.rds")
# lixel_pharmacy_SENGKANG <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_SENGKANG.rds")
# lixel_pharmacy_SERANGOON <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_SERANGOON.rds")
# lixel_pharmacy_TAMPINES <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_TAMPINES.rds")
# lixel_pharmacy_TANGLIN <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_TANGLIN.rds")
# lixel_pharmacy_TOA_PAYOH <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_TOA_PAYOH.rds")
# lixel_pharmacy_TUAS <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_TUAS.rds")
# lixel_pharmacy_WOODLANDS <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_WOODLANDS.rds")
# lixel_pharmacy_YISHUN <- readRDS("data/rds/lixel/pharmacy/lixel_pharmacy_YISHUN.rds")

# setwd("../../facilities/combined/gym")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_gym_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/gym/hdb_gym_ANG_MO_KIO.rds")
# hdb_gym_BEDOK <- readRDS("data/rds/facilities/combined/gym/hdb_gym_BEDOK.rds")
# hdb_gym_BISHAN <- readRDS("data/rds/facilities/combined/gym/hdb_gym_BISHAN.rds")
# hdb_gym_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/gym/hdb_gym_BUKIT_BATOK.rds")
# hdb_gym_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/gym/hdb_gym_BUKIT_MERAH.rds")
# hdb_gym_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/gym/hdb_gym_BUKIT_PANJANG.rds")
# hdb_gym_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/gym/hdb_gym_BUKIT_TIMAH.rds")
# hdb_gym_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/gym/hdb_gym_CHOA_CHU_KANG.rds")
# hdb_gym_CLEMENTI <- readRDS("data/rds/facilities/combined/gym/hdb_gym_CLEMENTI.rds")
# hdb_gym_GEYLANG <- readRDS("data/rds/facilities/combined/gym/hdb_gym_GEYLANG.rds")
# hdb_gym_HOUGANG <- readRDS("data/rds/facilities/combined/gym/hdb_gym_HOUGANG.rds")
# hdb_gym_JURONG_EAST <- readRDS("data/rds/facilities/combined/gym/hdb_gym_JURONG_EAST.rds")
# hdb_gym_JURONG_WEST <- readRDS("data/rds/facilities/combined/gym/hdb_gym_JURONG_WEST.rds")
# hdb_gym_KALLANG <- readRDS("data/rds/facilities/combined/gym/hdb_gym_KALLANG.rds")
# hdb_gym_MARINE_PARADE <- readRDS("data/rds/facilities/combined/gym/hdb_gym_MARINE_PARADE.rds")
# hdb_gym_NOVENA <- readRDS("data/rds/facilities/combined/gym/hdb_gym_NOVENA.rds")
# hdb_gym_OUTRAM <- readRDS("data/rds/facilities/combined/gym/hdb_gym_OUTRAM.rds")
# hdb_gym_PASIR_RIS <- readRDS("data/rds/facilities/combined/gym/hdb_gym_PASIR_RIS.rds")
# hdb_gym_PUNGGOL <- readRDS("data/rds/facilities/combined/gym/hdb_gym_PUNGGOL.rds")
# hdb_gym_QUEENSTOWN <- readRDS("data/rds/facilities/combined/gym/hdb_gym_QUEENSTOWN.rds")
# hdb_gym_ROCHOR <- readRDS("data/rds/facilities/combined/gym/hdb_gym_ROCHOR.rds")
# hdb_gym_SEMBAWANG <- readRDS("data/rds/facilities/combined/gym/hdb_gym_SEMBAWANG.rds")
# hdb_gym_SENGKANG <- readRDS("data/rds/facilities/combined/gym/hdb_gym_SENGKANG.rds")
# hdb_gym_SERANGOON <- readRDS("data/rds/facilities/combined/gym/hdb_gym_SERANGOON.rds")
# hdb_gym_TAMPINES <- readRDS("data/rds/facilities/combined/gym/hdb_gym_TAMPINES.rds")
# hdb_gym_TANGLIN <- readRDS("data/rds/facilities/combined/gym/hdb_gym_TANGLIN.rds")
# hdb_gym_TOA_PAYOH <- readRDS("data/rds/facilities/combined/gym/hdb_gym_TOA_PAYOH.rds")
# hdb_gym_TUAS <- readRDS("data/rds/facilities/combined/gym/hdb_gym_TUAS.rds")
# hdb_gym_WOODLANDS <- readRDS("data/rds/facilities/combined/gym/hdb_gym_WOODLANDS.rds")
# hdb_gym_YISHUN <- readRDS("data/rds/facilities/combined/gym/hdb_gym_YISHUN.rds")

# setwd("../../../lixel/gym")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_gym_ANG_MO_KIO <- readRDS("data/rds/lixel/gym/lixel_gym_ANG_MO_KIO.rds")
# lixel_gym_BEDOK <- readRDS("data/rds/lixel/gym/lixel_gym_BEDOK.rds")
# lixel_gym_BISHAN <- readRDS("data/rds/lixel/gym/lixel_gym_BISHAN.rds")
# lixel_gym_BUKIT_BATOK <- readRDS("data/rds/lixel/gym/lixel_gym_BUKIT_BATOK.rds")
# lixel_gym_BUKIT_MERAH <- readRDS("data/rds/lixel/gym/lixel_gym_BUKIT_MERAH.rds")
# lixel_gym_BUKIT_PANJANG <- readRDS("data/rds/lixel/gym/lixel_gym_BUKIT_PANJANG.rds")
# lixel_gym_BUKIT_TIMAH <- readRDS("data/rds/lixel/gym/lixel_gym_BUKIT_TIMAH.rds")
# lixel_gym_CHOA_CHU_KANG <- readRDS("data/rds/lixel/gym/lixel_gym_CHOA_CHU_KANG.rds")
# lixel_gym_CLEMENTI <- readRDS("data/rds/lixel/gym/lixel_gym_CLEMENTI.rds")
# lixel_gym_GEYLANG <- readRDS("data/rds/lixel/gym/lixel_gym_GEYLANG.rds")
# lixel_gym_HOUGANG <- readRDS("data/rds/lixel/gym/lixel_gym_HOUGANG.rds")
# lixel_gym_JURONG_EAST <- readRDS("data/rds/lixel/gym/lixel_gym_JURONG_EAST.rds")
# lixel_gym_JURONG_WEST <- readRDS("data/rds/lixel/gym/lixel_gym_JURONG_WEST.rds")
# lixel_gym_KALLANG <- readRDS("data/rds/lixel/gym/lixel_gym_KALLANG.rds")
# lixel_gym_MARINE_PARADE <- readRDS("data/rds/lixel/gym/lixel_gym_MARINE_PARADE.rds")
# lixel_gym_NOVENA <- readRDS("data/rds/lixel/gym/lixel_gym_NOVENA.rds")
# lixel_gym_OUTRAM <- readRDS("data/rds/lixel/gym/lixel_gym_OUTRAM.rds")
# lixel_gym_PASIR_RIS <- readRDS("data/rds/lixel/gym/lixel_gym_PASIR_RIS.rds")
# lixel_gym_PUNGGOL <- readRDS("data/rds/lixel/gym/lixel_gym_PUNGGOL.rds")
# lixel_gym_QUEENSTOWN <- readRDS("data/rds/lixel/gym/lixel_gym_QUEENSTOWN.rds")
# lixel_gym_ROCHOR <- readRDS("data/rds/lixel/gym/lixel_gym_ROCHOR.rds")
# lixel_gym_SEMBAWANG <- readRDS("data/rds/lixel/gym/lixel_gym_SEMBAWANG.rds")
# lixel_gym_SENGKANG <- readRDS("data/rds/lixel/gym/lixel_gym_SENGKANG.rds")
# lixel_gym_SERANGOON <- readRDS("data/rds/lixel/gym/lixel_gym_SERANGOON.rds")
# lixel_gym_TAMPINES <- readRDS("data/rds/lixel/gym/lixel_gym_TAMPINES.rds")
# lixel_gym_TANGLIN <- readRDS("data/rds/lixel/gym/lixel_gym_TANGLIN.rds")
# lixel_gym_TOA_PAYOH <- readRDS("data/rds/lixel/gym/lixel_gym_TOA_PAYOH.rds")
# lixel_gym_TUAS <- readRDS("data/rds/lixel/gym/lixel_gym_TUAS.rds")
# lixel_gym_WOODLANDS <- readRDS("data/rds/lixel/gym/lixel_gym_WOODLANDS.rds")
# lixel_gym_YISHUN <- readRDS("data/rds/lixel/gym/lixel_gym_YISHUN.rds")

# setwd("../../facilities/combined/hdb_carpark")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

hdb_carpark_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_ANG_MO_KIO.rds")
hdb_carpark_BEDOK <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_BEDOK.rds")
hdb_carpark_BISHAN <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_BISHAN.rds")
hdb_carpark_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_BUKIT_BATOK.rds")
hdb_carpark_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_BUKIT_MERAH.rds")
hdb_carpark_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_BUKIT_PANJANG.rds")
hdb_carpark_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_BUKIT_TIMAH.rds")
hdb_carpark_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_CHOA_CHU_KANG.rds")
hdb_carpark_CLEMENTI <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_CLEMENTI.rds")
hdb_carpark_GEYLANG <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_GEYLANG.rds")
hdb_carpark_HOUGANG <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_HOUGANG.rds")
hdb_carpark_JURONG_EAST <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_JURONG_EAST.rds")
hdb_carpark_JURONG_WEST <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_JURONG_WEST.rds")
hdb_carpark_KALLANG <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_KALLANG.rds")
hdb_carpark_MARINE_PARADE <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_MARINE_PARADE.rds")
hdb_carpark_NOVENA <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_NOVENA.rds")
hdb_carpark_OUTRAM <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_OUTRAM.rds")
hdb_carpark_PASIR_RIS <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_PASIR_RIS.rds")
hdb_carpark_PUNGGOL <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_PUNGGOL.rds")
hdb_carpark_QUEENSTOWN <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_QUEENSTOWN.rds")
hdb_carpark_ROCHOR <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_ROCHOR.rds")
hdb_carpark_SEMBAWANG <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_SEMBAWANG.rds")
hdb_carpark_SENGKANG <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_SENGKANG.rds")
hdb_carpark_SERANGOON <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_SERANGOON.rds")
hdb_carpark_TAMPINES <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_TAMPINES.rds")
hdb_carpark_TANGLIN <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_TANGLIN.rds")
hdb_carpark_TOA_PAYOH <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_TOA_PAYOH.rds")
hdb_carpark_TUAS <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_TUAS.rds")
hdb_carpark_WOODLANDS <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_WOODLANDS.rds")
hdb_carpark_YISHUN <- readRDS("data/rds/facilities/combined/hdb_carpark/hdb_carpark_YISHUN.rds")

# setwd("../../../lixel/hdb_carpark")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

lixel_carpark_ANG_MO_KIO <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_ANG_MO_KIO.rds")
lixel_carpark_BEDOK <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_BEDOK.rds")
lixel_carpark_BISHAN <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_BISHAN.rds")
lixel_carpark_BUKIT_BATOK <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_BUKIT_BATOK.rds")
lixel_carpark_BUKIT_MERAH <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_BUKIT_MERAH.rds")
lixel_carpark_BUKIT_PANJANG <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_BUKIT_PANJANG.rds")
lixel_carpark_BUKIT_TIMAH <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_BUKIT_TIMAH.rds")
lixel_carpark_CHOA_CHU_KANG <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_CHOA_CHU_KANG.rds")
lixel_carpark_CLEMENTI <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_CLEMENTI.rds")
lixel_carpark_GEYLANG <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_GEYLANG.rds")
lixel_carpark_HOUGANG <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_HOUGANG.rds")
lixel_carpark_JURONG_EAST <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_JURONG_EAST.rds")
lixel_carpark_JURONG_WEST <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_JURONG_WEST.rds")
lixel_carpark_KALLANG <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_KALLANG.rds")
lixel_carpark_MARINE_PARADE <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_MARINE_PARADE.rds")
lixel_carpark_NOVENA <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_NOVENA.rds")
lixel_carpark_OUTRAM <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_OUTRAM.rds")
lixel_carpark_PASIR_RIS <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_PASIR_RIS.rds")
lixel_carpark_PUNGGOL <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_PUNGGOL.rds")
lixel_carpark_QUEENSTOWN <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_QUEENSTOWN.rds")
lixel_carpark_ROCHOR <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_ROCHOR.rds")
lixel_carpark_SEMBAWANG <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_SEMBAWANG.rds")
lixel_carpark_SENGKANG <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_SENGKANG.rds")
lixel_carpark_SERANGOON <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_SERANGOON.rds")
lixel_carpark_TAMPINES <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_TAMPINES.rds")
lixel_carpark_TANGLIN <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_TANGLIN.rds")
lixel_carpark_TOA_PAYOH <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_TOA_PAYOH.rds")
lixel_carpark_TUAS <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_TUAS.rds")
lixel_carpark_WOODLANDS <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_WOODLANDS.rds")
lixel_carpark_YISHUN <- readRDS("data/rds/lixel/hdb_carpark/lixel_carpark_YISHUN.rds")

# setwd("../../facilities/combined/bus_stop")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

hdb_bus_stop_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_ANG_MO_KIO.rds")
hdb_bus_stop_BEDOK <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_BEDOK.rds")
hdb_bus_stop_BISHAN <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_BISHAN.rds")
hdb_bus_stop_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_BUKIT_BATOK.rds")
hdb_bus_stop_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_BUKIT_MERAH.rds")
hdb_bus_stop_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_BUKIT_PANJANG.rds")
hdb_bus_stop_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_BUKIT_TIMAH.rds")
hdb_bus_stop_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_CHOA_CHU_KANG.rds")
hdb_bus_stop_CLEMENTI <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_CLEMENTI.rds")
hdb_bus_stop_GEYLANG <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_GEYLANG.rds")
hdb_bus_stop_HOUGANG <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_HOUGANG.rds")
hdb_bus_stop_JURONG_EAST <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_JURONG_EAST.rds")
hdb_bus_stop_JURONG_WEST <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_JURONG_WEST.rds")
hdb_bus_stop_KALLANG <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_KALLANG.rds")
hdb_bus_stop_MARINE_PARADE <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_MARINE_PARADE.rds")
hdb_bus_stop_NOVENA <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_NOVENA.rds")
hdb_bus_stop_OUTRAM <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_OUTRAM.rds")
hdb_bus_stop_PASIR_RIS <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_PASIR_RIS.rds")
hdb_bus_stop_PUNGGOL <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_PUNGGOL.rds")
hdb_bus_stop_QUEENSTOWN <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_QUEENSTOWN.rds")
hdb_bus_stop_ROCHOR <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_ROCHOR.rds")
hdb_bus_stop_SEMBAWANG <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_SEMBAWANG.rds")
hdb_bus_stop_SENGKANG <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_SENGKANG.rds")
hdb_bus_stop_SERANGOON <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_SERANGOON.rds")
hdb_bus_stop_TAMPINES <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_TAMPINES.rds")
hdb_bus_stop_TANGLIN <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_TANGLIN.rds")
hdb_bus_stop_TOA_PAYOH <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_TOA_PAYOH.rds")
hdb_bus_stop_TUAS <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_TUAS.rds")
hdb_bus_stop_WOODLANDS <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_WOODLANDS.rds")
hdb_bus_stop_YISHUN <- readRDS("data/rds/facilities/combined/bus_stop/hdb_bus_stop_YISHUN.rds")

# setwd("../../../lixel/bus_stop")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

lixel_bus_stop_ANG_MO_KIO <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_ANG_MO_KIO.rds")
lixel_bus_stop_BEDOK <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_BEDOK.rds")
lixel_bus_stop_BISHAN <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_BISHAN.rds")
lixel_bus_stop_BUKIT_BATOK <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_BUKIT_BATOK.rds")
lixel_bus_stop_BUKIT_MERAH <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_BUKIT_MERAH.rds")
lixel_bus_stop_BUKIT_PANJANG <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_BUKIT_PANJANG.rds")
lixel_bus_stop_BUKIT_TIMAH <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_BUKIT_TIMAH.rds")
lixel_bus_stop_CHOA_CHU_KANG <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_CHOA_CHU_KANG.rds")
lixel_bus_stop_CLEMENTI <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_CLEMENTI.rds")
lixel_bus_stop_GEYLANG <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_GEYLANG.rds")
lixel_bus_stop_HOUGANG <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_HOUGANG.rds")
lixel_bus_stop_JURONG_EAST <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_JURONG_EAST.rds")
lixel_bus_stop_JURONG_WEST <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_JURONG_WEST.rds")
lixel_bus_stop_KALLANG <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_KALLANG.rds")
lixel_bus_stop_MARINE_PARADE <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_MARINE_PARADE.rds")
lixel_bus_stop_NOVENA <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_NOVENA.rds")
lixel_bus_stop_OUTRAM <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_OUTRAM.rds")
lixel_bus_stop_PASIR_RIS <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_PASIR_RIS.rds")
lixel_bus_stop_PUNGGOL <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_PUNGGOL.rds")
lixel_bus_stop_QUEENSTOWN <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_QUEENSTOWN.rds")
lixel_bus_stop_ROCHOR <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_ROCHOR.rds")
lixel_bus_stop_SEMBAWANG <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_SEMBAWANG.rds")
lixel_bus_stop_SENGKANG <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_SENGKANG.rds")
lixel_bus_stop_SERANGOON <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_SERANGOON.rds")
lixel_bus_stop_TAMPINES <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_TAMPINES.rds")
lixel_bus_stop_TANGLIN <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_TANGLIN.rds")
lixel_bus_stop_TOA_PAYOH <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_TOA_PAYOH.rds")
lixel_bus_stop_TUAS <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_TUAS.rds")
lixel_bus_stop_WOODLANDS <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_WOODLANDS.rds")
lixel_bus_stop_YISHUN <- readRDS("data/rds/lixel/bus_stop/lixel_bus_stop_YISHUN.rds")

# setwd("../../facilities/combined/hawker_healthy")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_hawker_healthy_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_ANG_MO_KIO.rds")
# hdb_hawker_healthy_BEDOK <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_BEDOK.rds")
# hdb_hawker_healthy_BISHAN <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_BISHAN.rds")
# hdb_hawker_healthy_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_BUKIT_BATOK.rds")
# hdb_hawker_healthy_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_BUKIT_MERAH.rds")
# hdb_hawker_healthy_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_BUKIT_PANJANG.rds")
# hdb_hawker_healthy_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_BUKIT_TIMAH.rds")
# hdb_hawker_healthy_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_CHOA_CHU_KANG.rds")
# hdb_hawker_healthy_CLEMENTI <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_CLEMENTI.rds")
# hdb_hawker_healthy_GEYLANG <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_GEYLANG.rds")
# hdb_hawker_healthy_HOUGANG <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_HOUGANG.rds")
# hdb_hawker_healthy_JURONG_EAST <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_JURONG_EAST.rds")
# hdb_hawker_healthy_JURONG_WEST <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_JURONG_WEST.rds")
# hdb_hawker_healthy_KALLANG <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_KALLANG.rds")
# hdb_hawker_healthy_MARINE_PARADE <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_MARINE_PARADE.rds")
# hdb_hawker_healthy_NOVENA <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_NOVENA.rds")
# hdb_hawker_healthy_OUTRAM <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_OUTRAM.rds")
# hdb_hawker_healthy_PASIR_RIS <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_PASIR_RIS.rds")
# hdb_hawker_healthy_PUNGGOL <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_PUNGGOL.rds")
# hdb_hawker_healthy_QUEENSTOWN <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_QUEENSTOWN.rds")
# hdb_hawker_healthy_ROCHOR <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_ROCHOR.rds")
# hdb_hawker_healthy_SEMBAWANG <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_SEMBAWANG.rds")
# hdb_hawker_healthy_SENGKANG <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_SENGKANG.rds")
# hdb_hawker_healthy_SERANGOON <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_SERANGOON.rds")
# hdb_hawker_healthy_TAMPINES <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_TAMPINES.rds")
# hdb_hawker_healthy_TANGLIN <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_TANGLIN.rds")
# hdb_hawker_healthy_TOA_PAYOH <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_TOA_PAYOH.rds")
# hdb_hawker_healthy_TUAS <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_TUAS.rds")
# hdb_hawker_healthy_WOODLANDS <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_WOODLANDS.rds")
# hdb_hawker_healthy_YISHUN <- readRDS("data/rds/facilities/combined/hawker_healthy/hdb_hawker_healthy_YISHUN.rds")

# setwd("../../../lixel/hawker_healthy")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_hawker_healthy_ANG_MO_KIO <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_ANG_MO_KIO.rds")
# lixel_hawker_healthy_BEDOK <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_BEDOK.rds")
# lixel_hawker_healthy_BISHAN <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_BISHAN.rds")
# lixel_hawker_healthy_BUKIT_BATOK <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_BUKIT_BATOK.rds")
# lixel_hawker_healthy_BUKIT_MERAH <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_BUKIT_MERAH.rds")
# lixel_hawker_healthy_BUKIT_PANJANG <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_BUKIT_PANJANG.rds")
# lixel_hawker_healthy_BUKIT_TIMAH <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_BUKIT_TIMAH.rds")
# lixel_hawker_healthy_CHOA_CHU_KANG <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_CHOA_CHU_KANG.rds")
# lixel_hawker_healthy_CLEMENTI <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_CLEMENTI.rds")
# lixel_hawker_healthy_GEYLANG <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_GEYLANG.rds")
# lixel_hawker_healthy_HOUGANG <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_HOUGANG.rds")
# lixel_hawker_healthy_JURONG_EAST <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_JURONG_EAST.rds")
# lixel_hawker_healthy_JURONG_WEST <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_JURONG_WEST.rds")
# lixel_hawker_healthy_KALLANG <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_KALLANG.rds")
# lixel_hawker_healthy_MARINE_PARADE <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_MARINE_PARADE.rds")
# lixel_hawker_healthy_NOVENA <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_NOVENA.rds")
# lixel_hawker_healthy_OUTRAM <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_OUTRAM.rds")
# lixel_hawker_healthy_PASIR_RIS <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_PASIR_RIS.rds")
# lixel_hawker_healthy_PUNGGOL <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_PUNGGOL.rds")
# lixel_hawker_healthy_QUEENSTOWN <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_QUEENSTOWN.rds")
# lixel_hawker_healthy_ROCHOR <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_ROCHOR.rds")
# lixel_hawker_healthy_SEMBAWANG <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_SEMBAWANG.rds")
# lixel_hawker_healthy_SENGKANG <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_SENGKANG.rds")
# lixel_hawker_healthy_SERANGOON <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_SERANGOON.rds")
# lixel_hawker_healthy_TAMPINES <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_TAMPINES.rds")
# lixel_hawker_healthy_TANGLIN <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_TANGLIN.rds")
# lixel_hawker_healthy_TOA_PAYOH <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_TOA_PAYOH.rds")
# lixel_hawker_healthy_TUAS <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_TUAS.rds")
# lixel_hawker_healthy_WOODLANDS <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_WOODLANDS.rds")
# lixel_hawker_healthy_YISHUN <- readRDS("data/rds/lixel/hawker_healthy/lixel_hawker_healthy_YISHUN.rds")

# setwd("../../facilities/combined/hawker_new")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

hdb_hawker_new_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_ANG_MO_KIO.rds")
hdb_hawker_new_BEDOK <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_BEDOK.rds")
hdb_hawker_new_BISHAN <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_BISHAN.rds")
hdb_hawker_new_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_BUKIT_BATOK.rds")
hdb_hawker_new_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_BUKIT_MERAH.rds")
hdb_hawker_new_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_BUKIT_PANJANG.rds")
hdb_hawker_new_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_BUKIT_TIMAH.rds")
hdb_hawker_new_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_CHOA_CHU_KANG.rds")
hdb_hawker_new_CLEMENTI <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_CLEMENTI.rds")
hdb_hawker_new_GEYLANG <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_GEYLANG.rds")
hdb_hawker_new_HOUGANG <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_HOUGANG.rds")
hdb_hawker_new_JURONG_EAST <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_JURONG_EAST.rds")
hdb_hawker_new_JURONG_WEST <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_JURONG_WEST.rds")
hdb_hawker_new_KALLANG <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_KALLANG.rds")
hdb_hawker_new_MARINE_PARADE <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_MARINE_PARADE.rds")
hdb_hawker_new_NOVENA <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_NOVENA.rds")
hdb_hawker_new_OUTRAM <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_OUTRAM.rds")
hdb_hawker_new_PASIR_RIS <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_PASIR_RIS.rds")
hdb_hawker_new_PUNGGOL <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_PUNGGOL.rds")
hdb_hawker_new_QUEENSTOWN <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_QUEENSTOWN.rds")
hdb_hawker_new_ROCHOR <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_ROCHOR.rds")
hdb_hawker_new_SEMBAWANG <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_SEMBAWANG.rds")
hdb_hawker_new_SENGKANG <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_SENGKANG.rds")
hdb_hawker_new_SERANGOON <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_SERANGOON.rds")
hdb_hawker_new_TAMPINES <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_TAMPINES.rds")
hdb_hawker_new_TANGLIN <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_TANGLIN.rds")
hdb_hawker_new_TOA_PAYOH <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_TOA_PAYOH.rds")
hdb_hawker_new_TUAS <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_TUAS.rds")
hdb_hawker_new_WOODLANDS <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_WOODLANDS.rds")
hdb_hawker_new_YISHUN <- readRDS("data/rds/facilities/combined/hawker_new/hdb_hawker_new_YISHUN.rds")

# setwd("../../../lixel/hawker_new")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

lixel_hawker_new_ANG_MO_KIO <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_ANG_MO_KIO.rds")
lixel_hawker_new_BEDOK <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_BEDOK.rds")
lixel_hawker_new_BISHAN <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_BISHAN.rds")
lixel_hawker_new_BUKIT_BATOK <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_BUKIT_BATOK.rds")
lixel_hawker_new_BUKIT_MERAH <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_BUKIT_MERAH.rds")
lixel_hawker_new_BUKIT_PANJANG <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_BUKIT_PANJANG.rds")
lixel_hawker_new_BUKIT_TIMAH <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_BUKIT_TIMAH.rds")
lixel_hawker_new_CHOA_CHU_KANG <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_CHOA_CHU_KANG.rds")
lixel_hawker_new_CLEMENTI <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_CLEMENTI.rds")
lixel_hawker_new_GEYLANG <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_GEYLANG.rds")
lixel_hawker_new_HOUGANG <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_HOUGANG.rds")
lixel_hawker_new_JURONG_EAST <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_JURONG_EAST.rds")
lixel_hawker_new_JURONG_WEST <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_JURONG_WEST.rds")
lixel_hawker_new_KALLANG <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_KALLANG.rds")
lixel_hawker_new_MARINE_PARADE <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_MARINE_PARADE.rds")
lixel_hawker_new_NOVENA <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_NOVENA.rds")
lixel_hawker_new_OUTRAM <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_OUTRAM.rds")
lixel_hawker_new_PASIR_RIS <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_PASIR_RIS.rds")
lixel_hawker_new_PUNGGOL <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_PUNGGOL.rds")
lixel_hawker_new_QUEENSTOWN <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_QUEENSTOWN.rds")
lixel_hawker_new_ROCHOR <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_ROCHOR.rds")
lixel_hawker_new_SEMBAWANG <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_SEMBAWANG.rds")
lixel_hawker_new_SENGKANG <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_SENGKANG.rds")
lixel_hawker_new_SERANGOON <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_SERANGOON.rds")
lixel_hawker_new_TAMPINES <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_TAMPINES.rds")
lixel_hawker_new_TANGLIN <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_TANGLIN.rds")
lixel_hawker_new_TOA_PAYOH <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_TOA_PAYOH.rds")
lixel_hawker_new_TUAS <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_TUAS.rds")
lixel_hawker_new_WOODLANDS <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_WOODLANDS.rds")
lixel_hawker_new_YISHUN <- readRDS("data/rds/lixel/hawker_new/lixel_hawker_new_YISHUN.rds")

# setwd("../../facilities/combined/kindergarten")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_kindergarten_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_ANG_MO_KIO.rds")
# hdb_kindergarten_BEDOK <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_BEDOK.rds")
# hdb_kindergarten_BISHAN <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_BISHAN.rds")
# hdb_kindergarten_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_BUKIT_BATOK.rds")
# hdb_kindergarten_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_BUKIT_MERAH.rds")
# hdb_kindergarten_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_BUKIT_PANJANG.rds")
# hdb_kindergarten_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_BUKIT_TIMAH.rds")
# hdb_kindergarten_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_CHOA_CHU_KANG.rds")
# hdb_kindergarten_CLEMENTI <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_CLEMENTI.rds")
# hdb_kindergarten_GEYLANG <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_GEYLANG.rds")
# hdb_kindergarten_HOUGANG <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_HOUGANG.rds")
# hdb_kindergarten_JURONG_EAST <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_JURONG_EAST.rds")
# hdb_kindergarten_JURONG_WEST <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_JURONG_WEST.rds")
# hdb_kindergarten_KALLANG <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_KALLANG.rds")
# hdb_kindergarten_MARINE_PARADE <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_MARINE_PARADE.rds")
# hdb_kindergarten_NOVENA <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_NOVENA.rds")
# hdb_kindergarten_OUTRAM <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_OUTRAM.rds")
# hdb_kindergarten_PASIR_RIS <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_PASIR_RIS.rds")
# hdb_kindergarten_PUNGGOL <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_PUNGGOL.rds")
# hdb_kindergarten_QUEENSTOWN <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_QUEENSTOWN.rds")
# hdb_kindergarten_ROCHOR <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_ROCHOR.rds")
# hdb_kindergarten_SEMBAWANG <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_SEMBAWANG.rds")
# hdb_kindergarten_SENGKANG <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_SENGKANG.rds")
# hdb_kindergarten_SERANGOON <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_SERANGOON.rds")
# hdb_kindergarten_TAMPINES <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_TAMPINES.rds")
# hdb_kindergarten_TANGLIN <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_TANGLIN.rds")
# hdb_kindergarten_TOA_PAYOH <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_TOA_PAYOH.rds")
# hdb_kindergarten_TUAS <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_TUAS.rds")
# hdb_kindergarten_WOODLANDS <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_WOODLANDS.rds")
# hdb_kindergarten_YISHUN <- readRDS("data/rds/facilities/combined/kindergarten/hdb_kindergarten_YISHUN.rds")

# setwd("../../../lixel/kindergarten")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_kindergarten_ANG_MO_KIO <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_ANG_MO_KIO.rds")
# lixel_kindergarten_BEDOK <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_BEDOK.rds")
# lixel_kindergarten_BISHAN <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_BISHAN.rds")
# lixel_kindergarten_BUKIT_BATOK <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_BUKIT_BATOK.rds")
# lixel_kindergarten_BUKIT_MERAH <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_BUKIT_MERAH.rds")
# lixel_kindergarten_BUKIT_PANJANG <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_BUKIT_PANJANG.rds")
# lixel_kindergarten_BUKIT_TIMAH <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_BUKIT_TIMAH.rds")
# lixel_kindergarten_CHOA_CHU_KANG <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_CHOA_CHU_KANG.rds")
# lixel_kindergarten_CLEMENTI <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_CLEMENTI.rds")
# lixel_kindergarten_GEYLANG <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_GEYLANG.rds")
# lixel_kindergarten_HOUGANG <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_HOUGANG.rds")
# lixel_kindergarten_JURONG_EAST <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_JURONG_EAST.rds")
# lixel_kindergarten_JURONG_WEST <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_JURONG_WEST.rds")
# lixel_kindergarten_KALLANG <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_KALLANG.rds")
# lixel_kindergarten_MARINE_PARADE <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_MARINE_PARADE.rds")
# lixel_kindergarten_NOVENA <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_NOVENA.rds")
# lixel_kindergarten_OUTRAM <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_OUTRAM.rds")
# lixel_kindergarten_PASIR_RIS <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_PASIR_RIS.rds")
# lixel_kindergarten_PUNGGOL <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_PUNGGOL.rds")
# lixel_kindergarten_QUEENSTOWN <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_QUEENSTOWN.rds")
# lixel_kindergarten_ROCHOR <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_ROCHOR.rds")
# lixel_kindergarten_SEMBAWANG <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_SEMBAWANG.rds")
# lixel_kindergarten_SENGKANG <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_SENGKANG.rds")
# lixel_kindergarten_SERANGOON <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_SERANGOON.rds")
# lixel_kindergarten_TAMPINES <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_TAMPINES.rds")
# lixel_kindergarten_TANGLIN <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_TANGLIN.rds")
# lixel_kindergarten_TOA_PAYOH <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_TOA_PAYOH.rds")
# lixel_kindergarten_TUAS <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_TUAS.rds")
# lixel_kindergarten_WOODLANDS <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_WOODLANDS.rds")
# lixel_kindergarten_YISHUN <- readRDS("data/rds/lixel/kindergarten/lixel_kindergarten_YISHUN.rds")

# setwd("../../facilities/combined/mrt")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

hdb_mrt_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_ANG_MO_KIO.rds")
hdb_mrt_BEDOK <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_BEDOK.rds")
hdb_mrt_BISHAN <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_BISHAN.rds")
hdb_mrt_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_BUKIT_BATOK.rds")
hdb_mrt_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_BUKIT_MERAH.rds")
hdb_mrt_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_BUKIT_PANJANG.rds")
hdb_mrt_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_BUKIT_TIMAH.rds")
hdb_mrt_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_CHOA_CHU_KANG.rds")
hdb_mrt_CLEMENTI <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_CLEMENTI.rds")
hdb_mrt_GEYLANG <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_GEYLANG.rds")
hdb_mrt_HOUGANG <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_HOUGANG.rds")
hdb_mrt_JURONG_EAST <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_JURONG_EAST.rds")
hdb_mrt_JURONG_WEST <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_JURONG_WEST.rds")
hdb_mrt_KALLANG <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_KALLANG.rds")
hdb_mrt_MARINE_PARADE <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_MARINE_PARADE.rds")
hdb_mrt_NOVENA <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_NOVENA.rds")
hdb_mrt_OUTRAM <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_OUTRAM.rds")
hdb_mrt_PASIR_RIS <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_PASIR_RIS.rds")
hdb_mrt_PUNGGOL <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_PUNGGOL.rds")
hdb_mrt_QUEENSTOWN <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_QUEENSTOWN.rds")
hdb_mrt_ROCHOR <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_ROCHOR.rds")
hdb_mrt_SEMBAWANG <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_SEMBAWANG.rds")
hdb_mrt_SENGKANG <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_SENGKANG.rds")
hdb_mrt_SERANGOON <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_SERANGOON.rds")
hdb_mrt_TAMPINES <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_TAMPINES.rds")
hdb_mrt_TANGLIN <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_TANGLIN.rds")
hdb_mrt_TOA_PAYOH <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_TOA_PAYOH.rds")
hdb_mrt_TUAS <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_TUAS.rds")
hdb_mrt_WOODLANDS <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_WOODLANDS.rds")
hdb_mrt_YISHUN <- readRDS("data/rds/facilities/combined/mrt/hdb_mrt_YISHUN.rds")

# setwd("../../../lixel/mrt")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

lixel_mrt_ANG_MO_KIO <- readRDS("data/rds/lixel/mrt/lixel_mrt_ANG_MO_KIO.rds")
lixel_mrt_BEDOK <- readRDS("data/rds/lixel/mrt/lixel_mrt_BEDOK.rds")
lixel_mrt_BISHAN <- readRDS("data/rds/lixel/mrt/lixel_mrt_BISHAN.rds")
lixel_mrt_BUKIT_BATOK <- readRDS("data/rds/lixel/mrt/lixel_mrt_BUKIT_BATOK.rds")
lixel_mrt_BUKIT_MERAH <- readRDS("data/rds/lixel/mrt/lixel_mrt_BUKIT_MERAH.rds")
lixel_mrt_BUKIT_PANJANG <- readRDS("data/rds/lixel/mrt/lixel_mrt_BUKIT_PANJANG.rds")
lixel_mrt_BUKIT_TIMAH <- readRDS("data/rds/lixel/mrt/lixel_mrt_BUKIT_TIMAH.rds")
lixel_mrt_CHOA_CHU_KANG <- readRDS("data/rds/lixel/mrt/lixel_mrt_CHOA_CHU_KANG.rds")
lixel_mrt_CLEMENTI <- readRDS("data/rds/lixel/mrt/lixel_mrt_CLEMENTI.rds")
lixel_mrt_GEYLANG <- readRDS("data/rds/lixel/mrt/lixel_mrt_GEYLANG.rds")
lixel_mrt_HOUGANG <- readRDS("data/rds/lixel/mrt/lixel_mrt_HOUGANG.rds")
lixel_mrt_JURONG_EAST <- readRDS("data/rds/lixel/mrt/lixel_mrt_JURONG_EAST.rds")
lixel_mrt_JURONG_WEST <- readRDS("data/rds/lixel/mrt/lixel_mrt_JURONG_WEST.rds")
lixel_mrt_KALLANG <- readRDS("data/rds/lixel/mrt/lixel_mrt_KALLANG.rds")
lixel_mrt_MARINE_PARADE <- readRDS("data/rds/lixel/mrt/lixel_mrt_MARINE_PARADE.rds")
lixel_mrt_NOVENA <- readRDS("data/rds/lixel/mrt/lixel_mrt_NOVENA.rds")
lixel_mrt_OUTRAM <- readRDS("data/rds/lixel/mrt/lixel_mrt_OUTRAM.rds")
lixel_mrt_PASIR_RIS <- readRDS("data/rds/lixel/mrt/lixel_mrt_PASIR_RIS.rds")
lixel_mrt_PUNGGOL <- readRDS("data/rds/lixel/mrt/lixel_mrt_PUNGGOL.rds")
lixel_mrt_QUEENSTOWN <- readRDS("data/rds/lixel/mrt/lixel_mrt_QUEENSTOWN.rds")
lixel_mrt_ROCHOR <- readRDS("data/rds/lixel/mrt/lixel_mrt_ROCHOR.rds")
lixel_mrt_SEMBAWANG <- readRDS("data/rds/lixel/mrt/lixel_mrt_SEMBAWANG.rds")
lixel_mrt_SENGKANG <- readRDS("data/rds/lixel/mrt/lixel_mrt_SENGKANG.rds")
lixel_mrt_SERANGOON <- readRDS("data/rds/lixel/mrt/lixel_mrt_SERANGOON.rds")
lixel_mrt_TAMPINES <- readRDS("data/rds/lixel/mrt/lixel_mrt_TAMPINES.rds")
lixel_mrt_TANGLIN <- readRDS("data/rds/lixel/mrt/lixel_mrt_TANGLIN.rds")
lixel_mrt_TOA_PAYOH <- readRDS("data/rds/lixel/mrt/lixel_mrt_TOA_PAYOH.rds")
lixel_mrt_TUAS <- readRDS("data/rds/lixel/mrt/lixel_mrt_TUAS.rds")
lixel_mrt_WOODLANDS <- readRDS("data/rds/lixel/mrt/lixel_mrt_WOODLANDS.rds")
lixel_mrt_YISHUN <- readRDS("data/rds/lixel/mrt/lixel_mrt_YISHUN.rds")

# setwd("../../facilities/combined/park")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_park_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/park/hdb_park_ANG_MO_KIO.rds")
# hdb_park_BEDOK <- readRDS("data/rds/facilities/combined/park/hdb_park_BEDOK.rds")
# hdb_park_BISHAN <- readRDS("data/rds/facilities/combined/park/hdb_park_BISHAN.rds")
# hdb_park_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/park/hdb_park_BUKIT_BATOK.rds")
# hdb_park_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/park/hdb_park_BUKIT_MERAH.rds")
# hdb_park_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/park/hdb_park_BUKIT_PANJANG.rds")
# hdb_park_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/park/hdb_park_BUKIT_TIMAH.rds")
# hdb_park_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/park/hdb_park_CHOA_CHU_KANG.rds")
# hdb_park_CLEMENTI <- readRDS("data/rds/facilities/combined/park/hdb_park_CLEMENTI.rds")
# hdb_park_GEYLANG <- readRDS("data/rds/facilities/combined/park/hdb_park_GEYLANG.rds")
# hdb_park_HOUGANG <- readRDS("data/rds/facilities/combined/park/hdb_park_HOUGANG.rds")
# hdb_park_JURONG_EAST <- readRDS("data/rds/facilities/combined/park/hdb_park_JURONG_EAST.rds")
# hdb_park_JURONG_WEST <- readRDS("data/rds/facilities/combined/park/hdb_park_JURONG_WEST.rds")
# hdb_park_KALLANG <- readRDS("data/rds/facilities/combined/park/hdb_park_KALLANG.rds")
# hdb_park_MARINE_PARADE <- readRDS("data/rds/facilities/combined/park/hdb_park_MARINE_PARADE.rds")
# hdb_park_NOVENA <- readRDS("data/rds/facilities/combined/park/hdb_park_NOVENA.rds")
# hdb_park_OUTRAM <- readRDS("data/rds/facilities/combined/park/hdb_park_OUTRAM.rds")
# hdb_park_PASIR_RIS <- readRDS("data/rds/facilities/combined/park/hdb_park_PASIR_RIS.rds")
# hdb_park_PUNGGOL <- readRDS("data/rds/facilities/combined/park/hdb_park_PUNGGOL.rds")
# hdb_park_QUEENSTOWN <- readRDS("data/rds/facilities/combined/park/hdb_park_QUEENSTOWN.rds")
# hdb_park_ROCHOR <- readRDS("data/rds/facilities/combined/park/hdb_park_ROCHOR.rds")
# hdb_park_SEMBAWANG <- readRDS("data/rds/facilities/combined/park/hdb_park_SEMBAWANG.rds")
# hdb_park_SENGKANG <- readRDS("data/rds/facilities/combined/park/hdb_park_SENGKANG.rds")
# hdb_park_SERANGOON <- readRDS("data/rds/facilities/combined/park/hdb_park_SERANGOON.rds")
# hdb_park_TAMPINES <- readRDS("data/rds/facilities/combined/park/hdb_park_TAMPINES.rds")
# hdb_park_TANGLIN <- readRDS("data/rds/facilities/combined/park/hdb_park_TANGLIN.rds")
# hdb_park_TOA_PAYOH <- readRDS("data/rds/facilities/combined/park/hdb_park_TOA_PAYOH.rds")
# hdb_park_TUAS <- readRDS("data/rds/facilities/combined/park/hdb_park_TUAS.rds")
# hdb_park_WOODLANDS <- readRDS("data/rds/facilities/combined/park/hdb_park_WOODLANDS.rds")
# hdb_park_YISHUN <- readRDS("data/rds/facilities/combined/park/hdb_park_YISHUN.rds")

# setwd("../../../lixel/park")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_park_ANG_MO_KIO <- readRDS("data/rds/lixel/park/lixel_park_ANG_MO_KIO.rds")
# lixel_park_BEDOK <- readRDS("data/rds/lixel/park/lixel_park_BEDOK.rds")
# lixel_park_BISHAN <- readRDS("data/rds/lixel/park/lixel_park_BISHAN.rds")
# lixel_park_BUKIT_BATOK <- readRDS("data/rds/lixel/park/lixel_park_BUKIT_BATOK.rds")
# lixel_park_BUKIT_MERAH <- readRDS("data/rds/lixel/park/lixel_park_BUKIT_MERAH.rds")
# lixel_park_BUKIT_PANJANG <- readRDS("data/rds/lixel/park/lixel_park_BUKIT_PANJANG.rds")
# lixel_park_BUKIT_TIMAH <- readRDS("data/rds/lixel/park/lixel_park_BUKIT_TIMAH.rds")
# lixel_park_CHOA_CHU_KANG <- readRDS("data/rds/lixel/park/lixel_park_CHOA_CHU_KANG.rds")
# lixel_park_CLEMENTI <- readRDS("data/rds/lixel/park/lixel_park_CLEMENTI.rds")
# lixel_park_GEYLANG <- readRDS("data/rds/lixel/park/lixel_park_GEYLANG.rds")
# lixel_park_HOUGANG <- readRDS("data/rds/lixel/park/lixel_park_HOUGANG.rds")
# lixel_park_JURONG_EAST <- readRDS("data/rds/lixel/park/lixel_park_JURONG_EAST.rds")
# lixel_park_JURONG_WEST <- readRDS("data/rds/lixel/park/lixel_park_JURONG_WEST.rds")
# lixel_park_KALLANG <- readRDS("data/rds/lixel/park/lixel_park_KALLANG.rds")
# lixel_park_MARINE_PARADE <- readRDS("data/rds/lixel/park/lixel_park_MARINE_PARADE.rds")
# lixel_park_NOVENA <- readRDS("data/rds/lixel/park/lixel_park_NOVENA.rds")
# lixel_park_OUTRAM <- readRDS("data/rds/lixel/park/lixel_park_OUTRAM.rds")
# lixel_park_PASIR_RIS <- readRDS("data/rds/lixel/park/lixel_park_PASIR_RIS.rds")
# lixel_park_PUNGGOL <- readRDS("data/rds/lixel/park/lixel_park_PUNGGOL.rds")
# lixel_park_QUEENSTOWN <- readRDS("data/rds/lixel/park/lixel_park_QUEENSTOWN.rds")
# lixel_park_ROCHOR <- readRDS("data/rds/lixel/park/lixel_park_ROCHOR.rds")
# lixel_park_SEMBAWANG <- readRDS("data/rds/lixel/park/lixel_park_SEMBAWANG.rds")
# lixel_park_SENGKANG <- readRDS("data/rds/lixel/park/lixel_park_SENGKANG.rds")
# lixel_park_SERANGOON <- readRDS("data/rds/lixel/park/lixel_park_SERANGOON.rds")
# lixel_park_TAMPINES <- readRDS("data/rds/lixel/park/lixel_park_TAMPINES.rds")
# lixel_park_TANGLIN <- readRDS("data/rds/lixel/park/lixel_park_TANGLIN.rds")
# lixel_park_TOA_PAYOH <- readRDS("data/rds/lixel/park/lixel_park_TOA_PAYOH.rds")
# lixel_park_TUAS <- readRDS("data/rds/lixel/park/lixel_park_TUAS.rds")
# lixel_park_WOODLANDS <- readRDS("data/rds/lixel/park/lixel_park_WOODLANDS.rds")
# lixel_park_YISHUN <- readRDS("data/rds/lixel/park/lixel_park_YISHUN.rds")

# setwd("../../facilities/combined/pri_schl")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_pri_schl_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_ANG_MO_KIO.rds")
# hdb_pri_schl_BEDOK <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_BEDOK.rds")
# hdb_pri_schl_BISHAN <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_BISHAN.rds")
# hdb_pri_schl_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_BUKIT_BATOK.rds")
# hdb_pri_schl_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_BUKIT_MERAH.rds")
# hdb_pri_schl_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_BUKIT_PANJANG.rds")
# hdb_pri_schl_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_BUKIT_TIMAH.rds")
# hdb_pri_schl_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_CHOA_CHU_KANG.rds")
# hdb_pri_schl_CLEMENTI <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_CLEMENTI.rds")
# hdb_pri_schl_GEYLANG <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_GEYLANG.rds")
# hdb_pri_schl_HOUGANG <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_HOUGANG.rds")
# hdb_pri_schl_JURONG_EAST <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_JURONG_EAST.rds")
# hdb_pri_schl_JURONG_WEST <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_JURONG_WEST.rds")
# hdb_pri_schl_KALLANG <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_KALLANG.rds")
# hdb_pri_schl_MARINE_PARADE <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_MARINE_PARADE.rds")
# hdb_pri_schl_NOVENA <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_NOVENA.rds")
# hdb_pri_schl_OUTRAM <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_OUTRAM.rds")
# hdb_pri_schl_PASIR_RIS <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_PASIR_RIS.rds")
# hdb_pri_schl_PUNGGOL <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_PUNGGOL.rds")
# hdb_pri_schl_QUEENSTOWN <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_QUEENSTOWN.rds")
# hdb_pri_schl_ROCHOR <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_ROCHOR.rds")
# hdb_pri_schl_SEMBAWANG <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_SEMBAWANG.rds")
# hdb_pri_schl_SENGKANG <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_SENGKANG.rds")
# hdb_pri_schl_SERANGOON <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_SERANGOON.rds")
# hdb_pri_schl_TAMPINES <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_TAMPINES.rds")
# hdb_pri_schl_TANGLIN <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_TANGLIN.rds")
# hdb_pri_schl_TOA_PAYOH <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_TOA_PAYOH.rds")
# hdb_pri_schl_TUAS <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_TUAS.rds")
# hdb_pri_schl_WOODLANDS <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_WOODLANDS.rds")
# hdb_pri_schl_YISHUN <- readRDS("data/rds/facilities/combined/pri_schl/hdb_pri_schl_YISHUN.rds")

# setwd("../../../lixel/pri_schl")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_pri_schl_ANG_MO_KIO <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_ANG_MO_KIO.rds")
# lixel_pri_schl_BEDOK <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_BEDOK.rds")
# lixel_pri_schl_BISHAN <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_BISHAN.rds")
# lixel_pri_schl_BUKIT_BATOK <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_BUKIT_BATOK.rds")
# lixel_pri_schl_BUKIT_MERAH <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_BUKIT_MERAH.rds")
# lixel_pri_schl_BUKIT_PANJANG <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_BUKIT_PANJANG.rds")
# lixel_pri_schl_BUKIT_TIMAH <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_BUKIT_TIMAH.rds")
# lixel_pri_schl_CHOA_CHU_KANG <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_CHOA_CHU_KANG.rds")
# lixel_pri_schl_CLEMENTI <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_CLEMENTI.rds")
# lixel_pri_schl_GEYLANG <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_GEYLANG.rds")
# lixel_pri_schl_HOUGANG <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_HOUGANG.rds")
# lixel_pri_schl_JURONG_EAST <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_JURONG_EAST.rds")
# lixel_pri_schl_JURONG_WEST <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_JURONG_WEST.rds")
# lixel_pri_schl_KALLANG <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_KALLANG.rds")
# lixel_pri_schl_MARINE_PARADE <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_MARINE_PARADE.rds")
# lixel_pri_schl_NOVENA <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_NOVENA.rds")
# lixel_pri_schl_OUTRAM <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_OUTRAM.rds")
# lixel_pri_schl_PASIR_RIS <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_PASIR_RIS.rds")
# lixel_pri_schl_PUNGGOL <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_PUNGGOL.rds")
# lixel_pri_schl_QUEENSTOWN <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_QUEENSTOWN.rds")
# lixel_pri_schl_ROCHOR <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_ROCHOR.rds")
# lixel_pri_schl_SEMBAWANG <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_SEMBAWANG.rds")
# lixel_pri_schl_SENGKANG <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_SENGKANG.rds")
# lixel_pri_schl_SERANGOON <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_SERANGOON.rds")
# lixel_pri_schl_TAMPINES <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_TAMPINES.rds")
# lixel_pri_schl_TANGLIN <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_TANGLIN.rds")
# lixel_pri_schl_TOA_PAYOH <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_TOA_PAYOH.rds")
# lixel_pri_schl_TUAS <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_TUAS.rds")
# lixel_pri_schl_WOODLANDS <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_WOODLANDS.rds")
# lixel_pri_schl_YISHUN <- readRDS("data/rds/lixel/pri_schl/lixel_pri_schl_YISHUN.rds")

# setwd("../../facilities/combined/shopping_mall")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

hdb_shopping_mall_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_ANG_MO_KIO.rds")
hdb_shopping_mall_BEDOK <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_BEDOK.rds")
hdb_shopping_mall_BISHAN <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_BISHAN.rds")
hdb_shopping_mall_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_BUKIT_BATOK.rds")
hdb_shopping_mall_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_BUKIT_MERAH.rds")
hdb_shopping_mall_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_BUKIT_PANJANG.rds")
hdb_shopping_mall_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_BUKIT_TIMAH.rds")
hdb_shopping_mall_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_CHOA_CHU_KANG.rds")
hdb_shopping_mall_CLEMENTI <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_CLEMENTI.rds")
hdb_shopping_mall_GEYLANG <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_GEYLANG.rds")
hdb_shopping_mall_HOUGANG <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_HOUGANG.rds")
hdb_shopping_mall_JURONG_EAST <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_JURONG_EAST.rds")
hdb_shopping_mall_JURONG_WEST <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_JURONG_WEST.rds")
hdb_shopping_mall_KALLANG <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_KALLANG.rds")
hdb_shopping_mall_MARINE_PARADE <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_MARINE_PARADE.rds")
hdb_shopping_mall_NOVENA <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_NOVENA.rds")
hdb_shopping_mall_OUTRAM <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_OUTRAM.rds")
hdb_shopping_mall_PASIR_RIS <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_PASIR_RIS.rds")
hdb_shopping_mall_PUNGGOL <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_PUNGGOL.rds")
hdb_shopping_mall_QUEENSTOWN <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_QUEENSTOWN.rds")
hdb_shopping_mall_ROCHOR <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_ROCHOR.rds")
hdb_shopping_mall_SEMBAWANG <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_SEMBAWANG.rds")
hdb_shopping_mall_SENGKANG <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_SENGKANG.rds")
hdb_shopping_mall_SERANGOON <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_SERANGOON.rds")
hdb_shopping_mall_TAMPINES <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_TAMPINES.rds")
hdb_shopping_mall_TANGLIN <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_TANGLIN.rds")
hdb_shopping_mall_TOA_PAYOH <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_TOA_PAYOH.rds")
hdb_shopping_mall_TUAS <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_TUAS.rds")
hdb_shopping_mall_WOODLANDS <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_WOODLANDS.rds")
hdb_shopping_mall_YISHUN <- readRDS("data/rds/facilities/combined/shopping_mall/hdb_shopping_mall_YISHUN.rds")

# setwd("../../../lixel/shopping_mall")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

lixel_shopping_mall_ANG_MO_KIO <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_ANG_MO_KIO.rds")
lixel_shopping_mall_BEDOK <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_BEDOK.rds")
lixel_shopping_mall_BISHAN <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_BISHAN.rds")
lixel_shopping_mall_BUKIT_BATOK <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_BUKIT_BATOK.rds")
lixel_shopping_mall_BUKIT_MERAH <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_BUKIT_MERAH.rds")
lixel_shopping_mall_BUKIT_PANJANG <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_BUKIT_PANJANG.rds")
lixel_shopping_mall_BUKIT_TIMAH <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_BUKIT_TIMAH.rds")
lixel_shopping_mall_CHOA_CHU_KANG <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_CHOA_CHU_KANG.rds")
lixel_shopping_mall_CLEMENTI <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_CLEMENTI.rds")
lixel_shopping_mall_GEYLANG <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_GEYLANG.rds")
lixel_shopping_mall_HOUGANG <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_HOUGANG.rds")
lixel_shopping_mall_JURONG_EAST <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_JURONG_EAST.rds")
lixel_shopping_mall_JURONG_WEST <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_JURONG_WEST.rds")
lixel_shopping_mall_KALLANG <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_KALLANG.rds")
lixel_shopping_mall_MARINE_PARADE <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_MARINE_PARADE.rds")
lixel_shopping_mall_NOVENA <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_NOVENA.rds")
lixel_shopping_mall_OUTRAM <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_OUTRAM.rds")
lixel_shopping_mall_PASIR_RIS <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_PASIR_RIS.rds")
lixel_shopping_mall_PUNGGOL <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_PUNGGOL.rds")
lixel_shopping_mall_QUEENSTOWN <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_QUEENSTOWN.rds")
lixel_shopping_mall_ROCHOR <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_ROCHOR.rds")
lixel_shopping_mall_SEMBAWANG <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_SEMBAWANG.rds")
lixel_shopping_mall_SENGKANG <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_SENGKANG.rds")
lixel_shopping_mall_SERANGOON <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_SERANGOON.rds")
lixel_shopping_mall_TAMPINES <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_TAMPINES.rds")
lixel_shopping_mall_TANGLIN <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_TANGLIN.rds")
lixel_shopping_mall_TOA_PAYOH <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_TOA_PAYOH.rds")
lixel_shopping_mall_TUAS <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_TUAS.rds")
lixel_shopping_mall_WOODLANDS <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_WOODLANDS.rds")
lixel_shopping_mall_YISHUN <- readRDS("data/rds/lixel/shopping_mall/lixel_shopping_mall_YISHUN.rds")

# setwd("../../facilities/combined/spf")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_spf_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/spf/hdb_spf_ANG_MO_KIO.rds")
# hdb_spf_BEDOK <- readRDS("data/rds/facilities/combined/spf/hdb_spf_BEDOK.rds")
# hdb_spf_BISHAN <- readRDS("data/rds/facilities/combined/spf/hdb_spf_BISHAN.rds")
# hdb_spf_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/spf/hdb_spf_BUKIT_BATOK.rds")
# hdb_spf_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/spf/hdb_spf_BUKIT_MERAH.rds")
# hdb_spf_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/spf/hdb_spf_BUKIT_PANJANG.rds")
# hdb_spf_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/spf/hdb_spf_BUKIT_TIMAH.rds")
# hdb_spf_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/spf/hdb_spf_CHOA_CHU_KANG.rds")
# hdb_spf_CLEMENTI <- readRDS("data/rds/facilities/combined/spf/hdb_spf_CLEMENTI.rds")
# hdb_spf_GEYLANG <- readRDS("data/rds/facilities/combined/spf/hdb_spf_GEYLANG.rds")
# hdb_spf_HOUGANG <- readRDS("data/rds/facilities/combined/spf/hdb_spf_HOUGANG.rds")
# hdb_spf_JURONG_EAST <- readRDS("data/rds/facilities/combined/spf/hdb_spf_JURONG_EAST.rds")
# hdb_spf_JURONG_WEST <- readRDS("data/rds/facilities/combined/spf/hdb_spf_JURONG_WEST.rds")
# hdb_spf_KALLANG <- readRDS("data/rds/facilities/combined/spf/hdb_spf_KALLANG.rds")
# hdb_spf_MARINE_PARADE <- readRDS("data/rds/facilities/combined/spf/hdb_spf_MARINE_PARADE.rds")
# hdb_spf_NOVENA <- readRDS("data/rds/facilities/combined/spf/hdb_spf_NOVENA.rds")
# hdb_spf_OUTRAM <- readRDS("data/rds/facilities/combined/spf/hdb_spf_OUTRAM.rds")
# hdb_spf_PASIR_RIS <- readRDS("data/rds/facilities/combined/spf/hdb_spf_PASIR_RIS.rds")
# hdb_spf_PUNGGOL <- readRDS("data/rds/facilities/combined/spf/hdb_spf_PUNGGOL.rds")
# hdb_spf_QUEENSTOWN <- readRDS("data/rds/facilities/combined/spf/hdb_spf_QUEENSTOWN.rds")
# hdb_spf_ROCHOR <- readRDS("data/rds/facilities/combined/spf/hdb_spf_ROCHOR.rds")
# hdb_spf_SEMBAWANG <- readRDS("data/rds/facilities/combined/spf/hdb_spf_SEMBAWANG.rds")
# hdb_spf_SENGKANG <- readRDS("data/rds/facilities/combined/spf/hdb_spf_SENGKANG.rds")
# hdb_spf_SERANGOON <- readRDS("data/rds/facilities/combined/spf/hdb_spf_SERANGOON.rds")
# hdb_spf_TAMPINES <- readRDS("data/rds/facilities/combined/spf/hdb_spf_TAMPINES.rds")
# hdb_spf_TANGLIN <- readRDS("data/rds/facilities/combined/spf/hdb_spf_TANGLIN.rds")
# hdb_spf_TOA_PAYOH <- readRDS("data/rds/facilities/combined/spf/hdb_spf_TOA_PAYOH.rds")
# hdb_spf_TUAS <- readRDS("data/rds/facilities/combined/spf/hdb_spf_TUAS.rds")
# hdb_spf_WOODLANDS <- readRDS("data/rds/facilities/combined/spf/hdb_spf_WOODLANDS.rds")
# hdb_spf_YISHUN <- readRDS("data/rds/facilities/combined/spf/hdb_spf_YISHUN.rds")

# setwd("../../../lixel/spf")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_spf_ANG_MO_KIO <- readRDS("data/rds/lixel/spf/lixel_spf_ANG_MO_KIO.rds")
# lixel_spf_BEDOK <- readRDS("data/rds/lixel/spf/lixel_spf_BEDOK.rds")
# lixel_spf_BISHAN <- readRDS("data/rds/lixel/spf/lixel_spf_BISHAN.rds")
# lixel_spf_BUKIT_BATOK <- readRDS("data/rds/lixel/spf/lixel_spf_BUKIT_BATOK.rds")
# lixel_spf_BUKIT_MERAH <- readRDS("data/rds/lixel/spf/lixel_spf_BUKIT_MERAH.rds")
# lixel_spf_BUKIT_PANJANG <- readRDS("data/rds/lixel/spf/lixel_spf_BUKIT_PANJANG.rds")
# lixel_spf_BUKIT_TIMAH <- readRDS("data/rds/lixel/spf/lixel_spf_BUKIT_TIMAH.rds")
# lixel_spf_CHOA_CHU_KANG <- readRDS("data/rds/lixel/spf/lixel_spf_CHOA_CHU_KANG.rds")
# lixel_spf_CLEMENTI <- readRDS("data/rds/lixel/spf/lixel_spf_CLEMENTI.rds")
# lixel_spf_GEYLANG <- readRDS("data/rds/lixel/spf/lixel_spf_GEYLANG.rds")
# lixel_spf_HOUGANG <- readRDS("data/rds/lixel/spf/lixel_spf_HOUGANG.rds")
# lixel_spf_JURONG_EAST <- readRDS("data/rds/lixel/spf/lixel_spf_JURONG_EAST.rds")
# lixel_spf_JURONG_WEST <- readRDS("data/rds/lixel/spf/lixel_spf_JURONG_WEST.rds")
# lixel_spf_KALLANG <- readRDS("data/rds/lixel/spf/lixel_spf_KALLANG.rds")
# lixel_spf_MARINE_PARADE <- readRDS("data/rds/lixel/spf/lixel_spf_MARINE_PARADE.rds")
# lixel_spf_NOVENA <- readRDS("data/rds/lixel/spf/lixel_spf_NOVENA.rds")
# lixel_spf_OUTRAM <- readRDS("data/rds/lixel/spf/lixel_spf_OUTRAM.rds")
# lixel_spf_PASIR_RIS <- readRDS("data/rds/lixel/spf/lixel_spf_PASIR_RIS.rds")
# lixel_spf_PUNGGOL <- readRDS("data/rds/lixel/spf/lixel_spf_PUNGGOL.rds")
# lixel_spf_QUEENSTOWN <- readRDS("data/rds/lixel/spf/lixel_spf_QUEENSTOWN.rds")
# lixel_spf_ROCHOR <- readRDS("data/rds/lixel/spf/lixel_spf_ROCHOR.rds")
# lixel_spf_SEMBAWANG <- readRDS("data/rds/lixel/spf/lixel_spf_SEMBAWANG.rds")
# lixel_spf_SENGKANG <- readRDS("data/rds/lixel/spf/lixel_spf_SENGKANG.rds")
# lixel_spf_SERANGOON <- readRDS("data/rds/lixel/spf/lixel_spf_SERANGOON.rds")
# lixel_spf_TAMPINES <- readRDS("data/rds/lixel/spf/lixel_spf_TAMPINES.rds")
# lixel_spf_TANGLIN <- readRDS("data/rds/lixel/spf/lixel_spf_TANGLIN.rds")
# lixel_spf_TOA_PAYOH <- readRDS("data/rds/lixel/spf/lixel_spf_TOA_PAYOH.rds")
# lixel_spf_TUAS <- readRDS("data/rds/lixel/spf/lixel_spf_TUAS.rds")
# lixel_spf_WOODLANDS <- readRDS("data/rds/lixel/spf/lixel_spf_WOODLANDS.rds")
# lixel_spf_YISHUN <- readRDS("data/rds/lixel/spf/lixel_spf_YISHUN.rds")

# setwd("../../facilities/combined/supermarket")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# hdb_supermarket_ANG_MO_KIO <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_ANG_MO_KIO.rds")
# hdb_supermarket_BEDOK <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_BEDOK.rds")
# hdb_supermarket_BISHAN <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_BISHAN.rds")
# hdb_supermarket_BUKIT_BATOK <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_BUKIT_BATOK.rds")
# hdb_supermarket_BUKIT_MERAH <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_BUKIT_MERAH.rds")
# hdb_supermarket_BUKIT_PANJANG <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_BUKIT_PANJANG.rds")
# hdb_supermarket_BUKIT_TIMAH <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_BUKIT_TIMAH.rds")
# hdb_supermarket_CHOA_CHU_KANG <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_CHOA_CHU_KANG.rds")
# hdb_supermarket_CLEMENTI <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_CLEMENTI.rds")
# hdb_supermarket_GEYLANG <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_GEYLANG.rds")
# hdb_supermarket_HOUGANG <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_HOUGANG.rds")
# hdb_supermarket_JURONG_EAST <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_JURONG_EAST.rds")
# hdb_supermarket_JURONG_WEST <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_JURONG_WEST.rds")
# hdb_supermarket_KALLANG <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_KALLANG.rds")
# hdb_supermarket_MARINE_PARADE <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_MARINE_PARADE.rds")
# hdb_supermarket_NOVENA <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_NOVENA.rds")
# hdb_supermarket_OUTRAM <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_OUTRAM.rds")
# hdb_supermarket_PASIR_RIS <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_PASIR_RIS.rds")
# hdb_supermarket_PUNGGOL <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_PUNGGOL.rds")
# hdb_supermarket_QUEENSTOWN <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_QUEENSTOWN.rds")
# hdb_supermarket_ROCHOR <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_ROCHOR.rds")
# hdb_supermarket_SEMBAWANG <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_SEMBAWANG.rds")
# hdb_supermarket_SENGKANG <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_SENGKANG.rds")
# hdb_supermarket_SERANGOON <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_SERANGOON.rds")
# hdb_supermarket_TAMPINES <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_TAMPINES.rds")
# hdb_supermarket_TANGLIN <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_TANGLIN.rds")
# hdb_supermarket_TOA_PAYOH <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_TOA_PAYOH.rds")
# hdb_supermarket_TUAS <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_TUAS.rds")
# hdb_supermarket_WOODLANDS <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_WOODLANDS.rds")
# hdb_supermarket_YISHUN <- readRDS("data/rds/facilities/combined/supermarket/hdb_supermarket_YISHUN.rds")

# setwd("../../../lixel/supermarket")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# lixel_supermarket_ANG_MO_KIO <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_ANG_MO_KIO.rds")
# lixel_supermarket_BEDOK <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_BEDOK.rds")
# lixel_supermarket_BISHAN <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_BISHAN.rds")
# lixel_supermarket_BUKIT_BATOK <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_BUKIT_BATOK.rds")
# lixel_supermarket_BUKIT_MERAH <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_BUKIT_MERAH.rds")
# lixel_supermarket_BUKIT_PANJANG <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_BUKIT_PANJANG.rds")
# lixel_supermarket_BUKIT_TIMAH <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_BUKIT_TIMAH.rds")
# lixel_supermarket_CHOA_CHU_KANG <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_CHOA_CHU_KANG.rds")
# lixel_supermarket_CLEMENTI <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_CLEMENTI.rds")
# lixel_supermarket_GEYLANG <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_GEYLANG.rds")
# lixel_supermarket_HOUGANG <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_HOUGANG.rds")
# lixel_supermarket_JURONG_EAST <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_JURONG_EAST.rds")
# lixel_supermarket_JURONG_WEST <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_JURONG_WEST.rds")
# lixel_supermarket_KALLANG <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_KALLANG.rds")
# lixel_supermarket_MARINE_PARADE <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_MARINE_PARADE.rds")
# lixel_supermarket_NOVENA <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_NOVENA.rds")
# lixel_supermarket_OUTRAM <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_OUTRAM.rds")
# lixel_supermarket_PASIR_RIS <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_PASIR_RIS.rds")
# lixel_supermarket_PUNGGOL <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_PUNGGOL.rds")
# lixel_supermarket_QUEENSTOWN <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_QUEENSTOWN.rds")
# lixel_supermarket_ROCHOR <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_ROCHOR.rds")
# lixel_supermarket_SEMBAWANG <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_SEMBAWANG.rds")
# lixel_supermarket_SENGKANG <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_SENGKANG.rds")
# lixel_supermarket_SERANGOON <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_SERANGOON.rds")
# lixel_supermarket_TAMPINES <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_TAMPINES.rds")
# lixel_supermarket_TANGLIN <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_TANGLIN.rds")
# lixel_supermarket_TOA_PAYOH <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_TOA_PAYOH.rds")
# lixel_supermarket_TUAS <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_TUAS.rds")
# lixel_supermarket_WOODLANDS <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_WOODLANDS.rds")
# lixel_supermarket_YISHUN <- readRDS("data/rds/lixel/supermarket/lixel_supermarket_YISHUN.rds")

# setwd("../../kfunc")
# files <- list.files(pattern = ".rds")
# for (file in files) {
#   df_name <- sub(".rds", "", file)
#   assign(df_name, readRDS(file))
# }

# kfunc_ANG_MO_KIO <- readRDS("data/rds/kfunc/kfunc_ANG_MO_KIO.rds")
# kfunc_BEDOK <- readRDS("data/rds/kfunc/kfunc_BEDOK.rds")
# kfunc_BISHAN <- readRDS("data/rds/kfunc/kfunc_BISHAN.rds")
# kfunc_BUKIT_BATOK <- readRDS("data/rds/kfunc/kfunc_BUKIT_BATOK.rds")
# kfunc_BUKIT_MERAH <- readRDS("data/rds/kfunc/kfunc_BUKIT_MERAH.rds")
# kfunc_BUKIT_PANJANG <- readRDS("data/rds/kfunc/kfunc_BUKIT_PANJANG.rds")
# kfunc_BUKIT_TIMAH <- readRDS("data/rds/kfunc/kfunc_BUKIT_TIMAH.rds")
# kfunc_CHOA_CHU_KANG <- readRDS("data/rds/kfunc/kfunc_CHOA_CHU_KANG.rds")
# kfunc_CLEMENTI <- readRDS("data/rds/kfunc/kfunc_CLEMENTI.rds")
# kfunc_GEYLANG <- readRDS("data/rds/kfunc/kfunc_GEYLANG.rds")
# kfunc_HOUGANG <- readRDS("data/rds/kfunc/kfunc_HOUGANG.rds")
# kfunc_JURONG_EAST <- readRDS("data/rds/kfunc/kfunc_JURONG_EAST.rds")
# kfunc_JURONG_WEST <- readRDS("data/rds/kfunc/kfunc_JURONG_WEST.rds")
# kfunc_KALLANG <- readRDS("data/rds/kfunc/kfunc_KALLANG.rds")
# kfunc_MARINE_PARADE <- readRDS("data/rds/kfunc/kfunc_MARINE_PARADE.rds")
# kfunc_NOVENA <- readRDS("data/rds/kfunc/kfunc_NOVENA.rds")
# kfunc_OUTRAM <- readRDS("data/rds/kfunc/kfunc_OUTRAM.rds")
# kfunc_PASIR_RIS <- readRDS("data/rds/kfunc/kfunc_PASIR_RIS.rds")
# kfunc_PUNGGOL <- readRDS("data/rds/kfunc/kfunc_PUNGGOL.rds")
# kfunc_QUEENSTOWN <- readRDS("data/rds/kfunc/kfunc_QUEENSTOWN.rds")
# kfunc_ROCHOR <- readRDS("data/rds/kfunc/kfunc_ROCHOR.rds")
# kfunc_SEMBAWANG <- readRDS("data/rds/kfunc/kfunc_SEMBAWANG.rds")
# kfunc_SENGKANG <- readRDS("data/rds/kfunc/kfunc_SENGKANG.rds")
# kfunc_SERANGOON <- readRDS("data/rds/kfunc/kfunc_SERANGOON.rds")
# kfunc_TAMPINES <- readRDS("data/rds/kfunc/kfunc_TAMPINES.rds")
# kfunc_TANGLIN <- readRDS("data/rds/kfunc/kfunc_TANGLIN.rds")
# kfunc_TOA_PAYOH <- readRDS("data/rds/kfunc/kfunc_TOA_PAYOH.rds")
# kfunc_TUAS <- readRDS("data/rds/kfunc/kfunc_TUAS.rds")
# kfunc_WOODLANDS <- readRDS("data/rds/kfunc/kfunc_WOODLANDS.rds")
# kfunc_YISHUN <- readRDS("data/rds/kfunc/kfunc_YISHUN.rds")

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
                          p("On this page, we offer several tools designed to help you analyze the spatial distribution of points in your dataset. Our tools includes the Local Colocation Quotient Analysis (CLQ), Kernel Density Estimation (KDE), F-Function, Ripley L-Function, and Network Constraint Analysis. To access these tools, simply click on the five tabs located at the top of the page. Each tool provides a unique perspective on the spatial patterns in your data, allowing you to gain valuable insights into the underlying processes driving your observations. Whether you seek to comprehend the level of clustering present in your dataset, identify spatial patterns, or investigate the influence of network constraints on your observations, our toolkit offers a range of analytical tools to cater to your needs.")
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
                                                        choices = c("Childcare Centres" = "hdb_Childcare",
                                                                    "Eldercare Centres" = "hdb_Eldercare",
                                                                    "Kindergartens" = "hdb_Kindegarten",
                                                                    "Hawkercentres" = "hdb_Hawker",
                                                                    #"Healthier Hawkercentres" = "hawkercentre_healthy_sf",
                                                                    "National Parks" = "hdb_NationalParks",
                                                                    "Gyms" = "hdb_Gym",
                                                                    "Retail Pharmacy" = "hdb_Pharmacy",
                                                                    #"SPF" = "spf_sf",
                                                                    "Carparks" = "hdb_Carparks",
                                                                    "Supermarkets" = "hdb_Supermarket",
                                                                    "Bus stops" = "hdb_Bus",
                                                                    "Mrt" = "hdb_Mrt",
                                                                    "Primary Schools" = "hdb_PrimarySchool",
                                                                    "Shopping Malls" = "hdb_ShoppingMall"
                                                        ),
                                                        selected = "Childcare Centres"
                                            ),
                                            h4("Intepretation"),
                                            p("The application of colocation quotient (CLQ) is to determine whether the type of amenities is colocated with HDB. Each feature in the Category of Interest (category A) i.e HDB locations is evaluated individually for colocation with the presence of the Neighboring Category (category B) i.e other amenities found within its neighborhood. Generally, if a feature has a colocation quotient equal to one, it means the proportion of categories within their neighborhood is a good representation of the proportion of categories throughout the entire study area. Currently, for this CLQ map, it is already filtered to only show values where p_value <0.05."),
                                            tags$a(href="https://pro.arcgis.com/en/pro-app/latest/tool-reference/spatial-statistics/learnmorecolocationanalysis.htm", "Reference"),
                                          ),
                                          mainPanel(
                                            plotOutput("clq_outputmap"),
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
                                                     p("Please first select the type of KDE Amenity graph, the bandwidth, and the kernel from the dropdown menus, and then click the 'Plot KDE Graph' button. Take note that generating the graph may take some time."),
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
                                                     
                                                     actionButton("run_kde", "Plot KDE Graph"),
                                                     h4("Intepretation"),
                                                     p("Kernel density estimation is a widely utilized approach to display the density of spatial data points, which generates a smooth and continuous surface where each pixel represents a density value based on the number of points within a given distance bandwidth. The brighter clusters/areas tells us that the chosen amenity has a higher density in that area of the map."),
                                                     tags$a(href="https://r4gdsa.netlify.app/chap04.html#first-order-spatial-point-patterns-analysis", "Reference"),
                                                     
                                                   ),
                                                   mainPanel(
                                                     plotOutput("kde_plot")
                                                   )
                                     )
                                   )),
                          #end of KDE
                          
                          #### Tabset Ffunc ####
                          tabPanel("F-Function", fluidPage(
                            sidebarLayout(position = "right",
                                          sidebarPanel(
                                            h4("Description"),
                                            p("Please first select the area you would like to view the F-function graph of, and then click the 'Plot F-function graph' button. Take note that generating the graph may take some time."),
                                            selectInput("ffunc", label = h4("Area Name"), 
                                                        choices = area_names_1, 
                                                        selected = "BEDOK"),
                                            actionButton("run_ffunc", "Plot F-function graph"),
                                            h4("Intepretation"),
                                            p("Empty space distance is the measure of distance from a fixed reference location in the study window to the nearest data point, while the F function is the cumulative distribution function of the empty space distance. To confirm the observed spatial patterns, a hypothesis test will be conducted. The hypothesis and test are as follows:"),
                                            
                                            p("Ho = The distribution of HDB locations at your chosen area are randomly distributed."),
                                            
                                            p("H1= The distribution of HDB locations at your chosen area are not randomly distributed."),
                                            
                                            p("The null hypothesis will be rejected if p-value is smaller than alpha value of 0.05. If the observed F-function(the solid black line) lies outside the envelope(shaded area), it suggests that the data depart significantly from Complete Spatial Randomness (CSR)."),
                                            tags$a(href="https://r4gdsa.netlify.app/chap05.html#analysing-spatial-point-process-using-f-function", "Reference #1"),
                                            tags$a(href="https://rpubs.com/deniseadele/secondorder_pointpattern", "Reference #2"),
                                            
                                          ),
                                          mainPanel(
                                            plotOutput("ffunc_plot")
                                          )
                            )
                          )),
                          
                          #end of F-function
                          #### Tabset RIPLEY####
                          tabPanel("Ripley (L-Function)", fluidPage(
                            sidebarLayout(
                              position = "right",
                              sidebarPanel(
                                h4("Description"),
                                p("Please first select the area you would like to view the Ripley(L-function) graph of, and then click the 'Plot L-function Graph' button. Take note that generating the graph may take some time."),
                                
                                selectInput("rip", label = h4("Area Name"), 
                                            choices = area_names_1, 
                                            selected = "BEDOK"),
                                actionButton("run_rip", "Plot L-function Graph"),
                                h4("Intepretation"),
                                p("Pairwise distance refers to the distance between every unique pair of points in a given pattern. The K function calculates the average number of points that fall within a given distance r, and normalizes the result by dividing by the intensity of the study area.
An alternative form of the K-function is the L-function, which transforms the Poisson K-function into a straight line. The purpose is to make visual assessment of deviation easier. To confirm the observed spatial patterns, a hypothesis test will be conducted. The hypothesis and test are as follows:"),
                                
                                p("Ho = The distribution of HDB locations at your chosen area are randomly distributed."),
                                
                                p("H1= The distribution of HDB locations at your chosen area are not randomly distributed."),
                                
                                p("The null hypothesis will be rejected if p-value is smaller than alpha value of 0.05.If the observed L-function(the solid black line) lies outside the envelope(shaded area), it suggests that the data depart significantly from Complete Spatial Randomness (CSR)."),
                                
                                tags$a(href="https://rpubs.com/deniseadele/secondorder_pointpattern", "Reference"),
                                
                              ),
                              mainPanel(
                                plotlyOutput("rip_plot")
                              )
                            )
                          ))
                          ,
                          
                          
                          #### Tabset NETWORK ####
                          tabPanel("Network Constraint Analysis", fluidPage(
                            sidebarLayout(
                              position = "right",
                              sidebarPanel(
                                style = "margin-top: 25px;",
                                h2("Variables"),
                                selectInput("net_areaName", label = h4("Area Name"), 
                                            choices = area_names, 
                                            selected = "BISHAN"),
                                selectInput("net_facility", label = h4("Amenity Type"), 
                                            choices = list("Childcare" = "childcare",
                                                           "New Hawkers" = "hawker_new",
                                                           "HDB Carparks" = "carpark",
                                                           "Bus Stops" = "bus_stop",
                                                           "MRT" = "mrt",
                                                           "Shopping Mall" = "shopping_mall"), 
                                            selected = "Childcare"),
                                h2("Intepretation"),
                                p("The NetKDE analysis produces a density plot of road networks, where darker lines indicate more clustered or dense networks. This information can be useful in understanding which road networks generate more traffic, allowing potential HDB buyers to gauge the traffic situation in their preferred area. Additionally, we plotted the K-function to assess whether the observed spatial points of HDB flats were uniformly distributed over the street network. Our analysis showed that Punggol and Sembawang have the highest network density, followed by Choa Chu Kang, Bukit Batok, and Yishun. These regions are located in the north(-east) and west of Singapore. Conversely, the least dense network was observed in Tuas, which had only three HDB points. Overall, this information can be valuable for potential HDB buyers looking to make informed decisions based on their preferences and needs.")
                              ),
                              mainPanel(
                                h3("Lixel Plot"),
                                plotOutput("networkLixel"),
                                h3("K-Function Plot"),
                                imageOutput("networkKFunc"),
                              )
                            )
                          ))
                        ))), 

             #### Tabset Data Upload ####
             tabPanel("Data Upload",
                      fluidPage(
                        sidebarLayout(
                          sidebarPanel(
                            #fileInput("datafile", "Upload a file"),
                            # textInput("delim", "Delimiter (leave blank to guess)", ""),
                            # numericInput("skip", "Rows to skip", 0, min = 0),
                            # numericInput("rows", "Rows to preview", 5, min = 1)
                            #https://mastering-shiny.org/action-transfer.html
                            
                            fileInput("file", "Choose RDS file", accept = c(".rds")),
                            actionButton("preview", "Preview Data")
                          ),
                          mainPanel(
                            h3("Preview of Data (Top 10 Results)"),
                            tableOutput("data")
                          )
                        )
                      ))
  )


#### Define server logic
server <- function(input, output, session) {
  delay(3000, hide("note")) #delay function
  observeEvent(input$toggle, {
    toggle("tools_div")
  })
  
  
  #### Visualisations ####
  
  #initial
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
    tmap_mode("plot")
    clq_map <-
      tm_shape(mpsz_sf) +
      tm_polygons() +
      tm_shape(result, subset = result$amenity_pvalue < 0.05) + #filter out p_value less than 0.05 
      tm_dots(col = amenity_name,
              size = 0.01,
              border.col = "black",
              border.lwd = 0.5)
    
    output$clq_outputmap <- renderPlot(tmap_leaflet(clq_map))
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
  
  #### Ffunction ####
  observeEvent(input$run_ffunc,{
    bedok = mpsz[mpsz@data$PLN_AREA_N == input$ffunc,]
    bedok_sp = as(bedok, "SpatialPolygons")
    bedok_owin = as(bedok_sp, "owin")
    resale_bedok_ppp = resale_ppp_jit[bedok_owin]
    #resale_bedok_ppp.km = rescale(resale_bedok_ppp, 1000, "km")
    #plot(resale_bedok_ppp.km, main="bedok")
    
    #F_CK = Fest(resale_bedok_ppp)
    #plot(F_CK)
    
    set.seed(123)
    F_bedok.csr <- envelope(resale_bedok_ppp, Fest, nsim = 39)
    
    # Render plot
    output$ffunc_plot <- renderPlot({
      plot(F_bedok.csr, main="F-function Graph")
    })
  })
  
  #----- END Ffunction
  
  #### Ripley ####
  observeEvent(input$run_rip,{
    
    bedok = mpsz[mpsz@data$PLN_AREA_N  == input$rip,]
    bedok_sp = as(bedok, "SpatialPolygons")
    bedok_owin = as(bedok_sp, "owin")
    resale_bedok_ppp = resale_ppp_jit[bedok_owin]
    
    set.seed(123)
    L_bedok.csr <- envelope(resale_bedok_ppp, Lest, nsim = 39, rank = 1, glocal=TRUE)
    #plot(L_bedok.csr, . - r ~ r, 
    #xlab="d", ylab="L(d)-r", xlim=c(0,500))
    
    title <- "Pairwise Distance: L function"
    
    Lcsr_df <- as.data.frame(L_bedok.csr)
    
    colour=c("#0D657D","#ee770d","#D3D3D3")
    csr_plot <- ggplot(Lcsr_df, aes(r, obs-r))+
      # plot observed value
      geom_line(colour=c("#4d4d4d"))+
      geom_line(aes(r,theo-r), colour="red", linetype = "dashed")+
      # plot simulation envelopes
      geom_ribbon(aes(ymin=lo-r,ymax=hi-r),alpha=0.1, colour=c("#91bfdb")) +
      xlab("Distance r (m)") +
      ylab("L(r)-r") +
      geom_rug(data=Lcsr_df[Lcsr_df$obs > Lcsr_df$hi,], sides="b", colour=colour[1])  +
      geom_rug(data=Lcsr_df[Lcsr_df$obs < Lcsr_df$lo,], sides="b", colour=colour[2]) +
      geom_rug(data=Lcsr_df[Lcsr_df$obs >= Lcsr_df$lo & Lcsr_df$obs <= Lcsr_df$hi,], sides="b", color=colour[3]) +
      theme_tufte()+
      ggtitle(title)+theme(plot.title = element_text(hjust = 0.5))  # Center plot title
    
    text1<-"Significant clustering"
    text2<-"Significant segregation"
    text3<-"Not significant clustering/segregation"
    
    # the below conditional statement is required to ensure that the labels (text1/2/3) are assigned to the correct traces
    if (nrow(Lcsr_df[Lcsr_df$obs > Lcsr_df$hi,])==0){ 
      if (nrow(Lcsr_df[Lcsr_df$obs < Lcsr_df$lo,])==0){ 
        ggplotly(csr_plot, dynamicTicks=T) %>%
          style(text = text3, traces = 4) %>%
          rangeslider() 
      }else if (nrow(Lcsr_df[Lcsr_df$obs >= Lcsr_df$lo & Lcsr_df$obs <= Lcsr_df$hi,])==0){ 
        ggplotly(csr_plot, dynamicTicks=T) %>%
          style(text = text2, traces = 4) %>%
          rangeslider() 
      }else {
        ggplotly(csr_plot, dynamicTicks=T) %>%
          style(text = text2, traces = 4) %>%
          style(text = text3, traces = 5) %>%
          rangeslider() 
      }
    } else if (nrow(Lcsr_df[Lcsr_df$obs < Lcsr_df$lo,])==0){
      if (nrow(Lcsr_df[Lcsr_df$obs >= Lcsr_df$lo & Lcsr_df$obs <= Lcsr_df$hi,])==0){
        ggplotly(csr_plot, dynamicTicks=T) %>%
          style(text = text1, traces = 4) %>%
          rangeslider() 
      } else{
        ggplotly(csr_plot, dynamicTicks=T) %>%
          style(text = text1, traces = 4) %>%
          style(text = text3, traces = 5) %>%
          rangeslider()
      }
    } else{
      ggplotly(csr_plot, dynamicTicks=T) %>%
        style(text = text1, traces = 4) %>%
        style(text = text2, traces = 5) %>%
        style(text = text3, traces = 6) %>%
        rangeslider()
    }
    
    # Render plot
    output$rip_plot <- renderPlotly({
      csr_plot
    })
  })
  
  
  
  #### NETWORK ANALYSIS ####
  output$networkLixel <- renderPlot(
    tm_shape(get(paste0("shape_", input$net_areaName))) +
      tm_polygons() +
      tm_shape(get(paste0("lixel_",input$net_facility, "_", input$net_areaName)))+
      tm_lines(col="density", lwd=2)+
      tm_shape(get(paste0("hdb_",input$net_facility, "_", input$net_areaName)))+
      tm_dots(col = "Point Type", palette=c('blue', 'red'))
  )
  output$networkKFunc <- renderImage({
    filename <- normalizePath(file.path('./images',
                                        paste('kfunc_', input$net_areaName, '.jpg', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename)}, deleteFile = FALSE
  )
  
  #### Uploaded data ####

  # Read data from RDS file
  data <- reactive({
    req(input$file)
    readRDS(input$file$datapath)
  })

  # Convert to sf object and then data frame
  data_df <- reactive({
    if ("sf" %in% class(data())) {
      st_as_sf(data()) %>% st_set_geometry(NULL) %>% as.data.frame()
    } else {
      data()
    }
  })

  # Preview data when button is clicked
  observeEvent(input$preview, {
    output$data <- renderTable({
      head(data_df(), n = 10)
    })
  })
  
  observeEvent(input$file, {
    # Read data from RDS file
    data <- readRDS(input$file$datapath)
    
    # Update list of HDB amenities with new dataset name
    hdb_amenities <- c(input$HDB_amenities, input$file$name)
    
    # Combine original and updated list of amenities
    original_hdb_amenities <- c(
      "Overview of HDB Locations",
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
    )
    
    # Update HDB_amenities input with combined list of amenities
    updateSelectInput(session, "HDB_amenities", choices = c(original_hdb_amenities, hdb_amenities))
    
    # Save dataset as RDS file in data/rds folder
    saveRDS(data, paste0("data/rds/", input$file$name, ".rds"))
  })
  
  
  
  
  # raw <- reactive({
  #   req(input$upload)
  #   delim <- if (input$delim == "") NULL else input$delim
  #   vroom::vroom(input$upload$datapath, delim = delim, skip = input$skip)
  # })
  # output$uploadRaw <- renderTable(head(raw(), input$rows))
  # 
  # upload_sf <- reactive({
  #   st_as_sf(x = input$upload, 
  #            coords = c("longitude", "latitude"),
  #            crs = 3414)})
  # output$uploadPlot <- renderPlot(
  #   tm_shape(upload_sf())+
  #     tm_dots()
  # )
  
}


# Run the application 
shinyApp(ui = ui, server = server)