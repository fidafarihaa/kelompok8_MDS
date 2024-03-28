library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(RPostgreSQL)
library(DBI)
library(DT)
library(bs4Dash)
library(dplyr)
library(plotly)
library(tidyverse)
library(rvest)

connectDB <- function() {
  driver <- dbDriver('PostgreSQL')
  # Set up connection to the ElephantSQL database server
  DB <- dbConnect(
    driver,
    dbname = "tohofgbn", # database name
    host = "topsy.db.elephantsql.com",
    user = "tohofgbn",
    password = "8Gug5rnOSsRde_O_n03g_NEr20S9o6_1"
  )
  return(DB)
}

#----------------------Query1--------------------------#
q1 <- print("
      SELECT u.Kode_Kabkot, u.Nama_Kabkot, u.Ibukota, u.Jml_pddk, p.Nama_Wisata, p.Alamat
      FROM Kabkot u
      JOIN Wisata p ON u.Kode_Kabkot=p.Kode_Kabkot
")

#----------------------Query2--------------------------#
q2 <- paste0("
      SELECT w.Kode_Kec, w.Nama_Kec, w.Jml_pddk_kec, p.Nama_Wisata, P.Alamat
      FROM Kecamatan AS w
      JOIN Wisata p ON w.Kode_Kec = p.Kode_Kec"
)

#----------------------Query3--------------------------#
q3<-paste0("
      SELECT u.Kode_Kel, u.Nama_Kel, u.Jml_pddk_kel, p.Nama_Wisata, P.Alamat
      FROM kelurahan AS u
      JOIN Wisata p ON u.Kode_Kel = p.Kode_Kel
"
)

#----------------------Query4--------------------------#
q4<-paste0("
      SELECT p.Kode_Wisata, p.Tipe_Wisata, p.Nama_Wisata, p.Deskripsi, p.Harga_Tiket, p.Rating, p.Alamat
      FROM Wisata AS p
      JOIN Kecamatan w ON p.Kode_Kec = w.Kode_Kec
      JOIN Kelurahan u ON p.Kode_Kel = u.Kode_Kel
"
)

DB <- connectDB()
tabel01 <- data.frame(dbGetQuery(DB, q1))
tabel02 <- data.frame(dbGetQuery(DB, q2))
tabel03 <- data.frame(dbGetQuery(DB, q3))
tabel04 <- data.frame(dbGetQuery(DB, q4))
dbDisconnect(DB)



#==========================SERVER(BACK-END)===============================#
server <- function(input, output) {
  
  #----------------Tab Cari Kab/kot-----------------#
  # Filter Kabkot
  output$filter_1 <- renderUI({
    selectInput(
      inputId = "in_kabkot",
      label = "Pilih Kabupaten/kota",
      selected = "",
      choices = sort(tabel01$nama_kabkot)
    )
  })
  data1 <- reactive({
    tabel01 %>% filter(nama_kabkot%in% input$in_kabkot)
  })
  
  output$out_tbl1 <- renderDataTable({
    data1()
  })
  
  #----------------Tab Cari Kecamatan-----------------#
  # Filter Kecamatan
  output$filter_2 <- renderUI({
    selectInput(
      inputId = "in_kecamatan",
      label = "Pilih kecamatan",
      selected = "",
      choices = sort(tabel02$nama_kec)
    )
  })
  data2 <- reactive({
    tabel02 %>% filter(nama_kec %in% input$in_kecamatan)
  })
  
  
  output$out_tbl2 <- renderDataTable({
    data2()
  })
  #----------------Tab Cari Kelurahan-----------------#
  # Filter Kelurahan
  output$filter_3 <- renderUI({
    selectInput(
      inputId = "in_kelurahan",
      label = "Pilih kelurahan",
      selected = "",
      choices = sort(tabel03$nama_kel)
    )
  })
  
  data3 <- reactive({
    tabel03 %>% filter(nama_kel %in% input$in_kelurahan)
  })
  
  output$out_tbl3 <- renderDataTable({
    data3()
  })
  #----------------Tab Cari Tipe Wisata-----------------#
  # Filter tipe wisata
  output$filter_4 <- renderUI({
    selectInput(
      inputId = "in_tipe",
      label = "Pilih tipe wisata",
      selected = "",
      choices = sort(tabel04$tipe_wisata)
    )
  })
  
  data4 <- reactive({
    tabel04 %>% filter(tipe_wisata %in% input$in_tipe)
  })
  
  output$out_tbl4 <- renderDataTable({
    data4()
  })
}