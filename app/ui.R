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
#=========================== Interface (Front-End) ============================#

fluidPage(
  dashboardPage(
    header = dashboardHeader(
      title = div(
        style = "display: flex; align-items: center; justify-content: center;",
        img(src = "jabar.png", height = 50, width = 50),  # Ganti "logo.png" dengan path gambar logo Anda
        div(
          "Jawa Barat",
          style = "font-size:20px;color:#00000;font-weight:bold;text-align:center;margin-left:10px;"
        )
      ),
      titleWidth = 400  # Menyesuaikan lebar judul
    ),
    
    
    #------------SIDEBAR-----------------#
    sidebar = dashboardSidebar(
      collapsed = FALSE,
      sidebarMenu(
        menuItem(
          text = "Home",
          tabName = "beranda",
          icon = icon("home")
        ),
        menuItem(
          text = "Wisata",
          tabName = "wisata",
          icon = icon("fa-mountain-sun",class="fa-solid")
        ),
        menuItem(
          text = "Kabupaten/Kota",
          tabName = "kota",
          icon = icon("fa-building",class="fa-solid")
        ),
        menuItem(
          text = "Kecamatan",
          tabName = "kecamatan",
          icon = icon("city", class = "fa-solid")
        ),
        menuItem(
          text = "Kelurahan",
          tabName = "kelurahan",
          icon = icon("fa-tree-city",class="fa-solid")
        ),
        menuItem(
          text = "Team",
          tabName = "info",
          icon = icon("fa-users-line",class="fa-solid")
        )
        
      ),
      style = "background-color:#F8F8FF; font-size:20px;font-weight:bold; padding: 8px; border-radius: 4px;",
      HTML(paste0(
        "<br><br><br><br><br><br><br><br><br>",
        "<table style='margin-left:auto; margin-right:auto;'>",
        "<tr>",
        "<td style='padding: 5px;'><a href='https://www.facebook.com/parbudjabar/' target='_blank'><i class='fab fa-facebook-square fa-lg'></i></a></td>",
        "<td style='padding: 5px;'><a href='http://www.youtube.com/@WestJava_Tourism' target='_blank'><i class='fab fa-youtube fa-lg'></i></a></td>",
        "<td style='padding: 5px;'><a href='https://twitter.com/disparbud_jabar' target='_blank'><i class='fab fa-twitter fa-lg'></i></a></td>",
        "<td style='padding: 5px;'><a href='https://www.instagram.com/disparbudjabar/' target='_blank'><i class='fab fa-instagram fa-lg'></i></a></td>",
        "</tr>",
        "</table>",
        "<br>"
      ))
    ),
    
    #-----------------BODY-----------------#
     body = dashboardBody(
        tabItems(
        #-------------------------Tab Beranda-------------------------#
        tabItem(
          tabName = "beranda",
          jumbotron(
            title = span(
              img(src = "jabar.png", height = 300, width = 350),
              "Pariwisata Jawa Barat",
              style = "font-size:90px;font-weight:bold;display: flex;align-items: center"
            ),
            lead = span("Selamat Datang di Jawa Barat!", style = "font-size:30px;font-weight:bold;display: flex;align-items: center;background-color: #f8e5b3; padding: 20px; border-radius: 5px;"),
            href = "https://disparbud.jabarprov.go.id",
            status = "warning"
          ),
          
          fluidRow(
            tabItem(
              tabName = "beranda",
              jumbotron(
                title = div(
                  div(
                    img(src = "gunung.jpg", height = 150, width = 175, style = "margin-right: 10px;"), # First image
                    img(src = "air terjun.jpeg", height = 150, width = 175, style = "margin-right: 10px;"), # Second image
                    img(src = "hutan.jpg", height = 150, width = 175), # Third image
                    style = "display:flex;align-items:center;justify-content:center;margin-bottom:20px;" # CSS styling for image alignment
                  ),
                  style = "text-align:center;" # Center align the text
                ),
                href = "https://disparbud.jabarprov.go.id/category/wisata/",
                status = "primary",
                p("Jawa Barat adalah destinasi pariwisata yang mengagumkan dengan keindahan alam dan kekayaan budaya yang memukau. 
        Salah satu daya tarik utama di Jawa Barat adalah keberadaan curug atau air terjun yang menawan. 
        Dari hamparan hijau Puncak hingga pegunungan yang mempesona, 
        Jawa Barat menyajikan pemandangan alam yang menakjubkan.")
              )
            )
          )
        )
        ,
        
        #--------------------------Tab wisata--------------------------#
        
        tabItem(
          tabName = "wisata",
          fluidRow(
            tags$h1("Wisata Berdasarkan tipe wisata")
          ),
          fluidRow(
            # Filter tipe wisata
            box(
              tags$h3("Filter tipe wisata"),
              tags$p("Pilih tipe wisatayang diinginkan"),
              tags$br(),
              uiOutput("filter_4"),
              width = 6
            ),
            fluidRow(
              # Display tabel 
              box(
                tags$h3("Tabel"),
                dataTableOutput("out_tbl4"),
                width = 12
              )
            )
          )
        ),
        #--------------------------Tab kabupaten--------------------------#
        
        tabItem(
          tabName = "kota",
          fluidRow(
            tags$h1("Kabupaten/kota wisata")
          ),
          fluidRow(
            # Filter kabupaten/kota
            box(
              tags$h3("Filter kabupaten/kota"),
              tags$p("Pilih kabupaten/kota Tujuan"),
              tags$br(),
              uiOutput("filter_1"),
              width = 6
            ),
            fluidRow(
              # Display tabel 
              box(
                tags$h3("Tabel"),
                dataTableOutput("out_tbl1"),
                width = 12
              )
            )
          )
        ),
        #--------------------------Tab kecamatan--------------------------#
        
        tabItem(
          tabName = "kecamatan",
          fluidRow(
            tags$h1("Kecamatan wisata")
          ),
          fluidRow(
            # Filter kecamatan
            box(
              tags$h3("Filter kecamatan"),
              tags$p("Pilih kecamatan Tujuan"),
              tags$br(),
              uiOutput("filter_2"),
              width = 6
            ),
            fluidRow(
              # Display tabel 
              box(
                tags$h3("Tabel"),
                dataTableOutput("out_tbl2"),
                width = 12
              )
            )
          )
        ),
        #--------------------------Tab kelurahan--------------------------#
        
        tabItem(
          tabName = "kelurahan",
          fluidRow(
            tags$h1("Kelurahan Wisata")
          ),
          fluidRow(
            # Filter kelurahan
            box(
              tags$h3("Filter kelurahan"),
              tags$p("Pilih kelurahan Tujuan"),
              tags$br(),
              uiOutput("filter_3"),
              width = 6
            ),
            fluidRow(
              # Display tabel 
              box(
                tags$h3("Tabel"),
                dataTableOutput("out_tbl3"),
                width = 12
              )
            )
          )
          ),
        #--------------------------Tab info--------------------------#
        tabItem(
          tabName = "info",
          tags$div(style = "background-color: #ADD8E6; color: #000000; padding: 20px; border-radius: 15px;",  # Biru muda background, teks hitam, sudut bulat
                   tags$div(style = "text-align: center;",  # Teks di tengah
                            tags$h1(style = "font-family: 'Times New Roman', serif; font-size: 50px; font-weight: bold;", "Anggota Kelompok 8")  # Teks dengan gaya Times New Roman
                   )
          ),
          tags$div(class = "row",
                   tags$div(class = "col", style = "background-color: #F5DEB3; color: #000000; padding: 20px; border-radius: 15px; margin: 10px;", "Asri Pratiwi (G1501231014) Technical Writer"),  # Cream tebal background, teks hitam
                   tags$div(class = "col", style = "background-color: #F5DEB3; color: #000000; padding: 20px; border-radius: 15px; margin: 10px;", "Billy (G1501231034) Frontend Developer"),  # Cream tebal background, teks hitam
                   tags$div(class = "col", style = "background-color: #F5DEB3; color: #000000; padding: 20px; border-radius: 15px; margin: 10px;", "Fida Fariha Amatullah (G1501231064) Database Manager"),  # Cream tebal background, teks hitam
                   tags$div(class = "col", style = "background-color: #F5DEB3; color: #000000; padding: 20px; border-radius: 15px; margin: 10px;", "Aleytha Illanugraha Kurnadipare (G1501231067) Backend Developer")  # Cream tebal background, teks hitam
          )
        )
        #--------------------------Tab about--------------------------#
        
      )
    )
  ),
  
  #-----------------FOOTER-----------------#
  footer = dashboardFooter(
    right = "© 2024 Kelompok 8"
  )
)


