
#header definition

header <- dashboardHeader(
    title = "Steel Defect Detection"

)

#sidebar definition

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(
            text = "Overview",
            tabName = "overview",
            icon = icon("newspaper-o")
        )
    ),


    sidebarMenu(
        menuItem(
            text = "Detection",
            tabName = "test",
            icon = icon("gear")
        )
    ),


    sidebarMenu(
        menuItem(
            text = "Contact",
            icon = icon("user-circle"),
            href = "https://www.linkedin.com/in/maruu/"
        )
    ),

    sidebarMenu(
        menuItem(
            text = "Datasets",
            icon = icon("database"),
            href = "https://github.com/watashiwamaru/steel-defect-surface-detection"
        )
    )
)



#body definition

body <- dashboardBody(
    # using custom CSS (disable dashboard skins)
    
    tags$head(tags$style(HTML('
                                  /* logo */
                                  .skin-blue .main-header .logo {
                                  background-color: darkslategray;
                                  font-family: "Bahnschrift";
                                  }

                                  /* logo when hovered */
                                  .skin-blue .main-header .logo:hover {
                                  background-color: darkslategray;
                                  font-family: "Bahnschrift";
                                  }

                                  /* navbar (rest of the header) */
                                  .skin-blue .main-header .navbar {
                                  background-color: darkslategray;
                                  }

                                  /* main sidebar */
                                  .skin-blue .main-sidebar {
                                  background-color: darkslategray;
                                  font-family: "Bahnschrift";
                                  }

                                  /* active selected tab in the sidebarmenu */
                                  .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                                  background-color: seagreen;
                                  color: white;
                                  font-family: "Bahnschrift";
                                  }

                                  /* other links in the sidebarmenu */
                                  .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                                  background-color: darkslategray;
                                  color: white;
                                  font-family: "Bahnschrift";
                                  }

                                  /* other links in the sidebarmenu when hovered */
                                  .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                                  background-color: seagreen;
                                  color: white;
                                  font-family: "Bahnschrift";
                                  }
                                  /* toggle button when hovered  */
                                  .skin-blue .main-header .navbar .sidebar-toggle:hover{
                                  background-color: seagreen;
                                  }

                                  /* body */
                                  .content-wrapper, .right-side {
                                  background-color: #ffffff;
                                  font-family: "Bahnschrift";

                                  }

                                  '))),
    
    tabItems(
        tabItem(
            tabName = "overview",

            fluidPage(
                box(
                    div(h3("Steel Defect Detection"), align = "center"),
                    tags$br(),
                    # div(style = "text-align: justify",
                    #     h4("Deteksi cacat pada logam dapat saja dilakukan secara tradisional dengan mata telanjang. Namun, itu membutuhkan resource dan waktu yang lama."
                    #        )),
                    # div(style = "text-align: justify",
                    #     h4("Oleh karena itu, penggunaan machine learning dapat membantu engineer mendeteksi cacat logam tanpa menghilangkan peran manusia sebagai pengambil keputusan akhir."
                    #        )),
                    htmlOutput("text1"),
                    width = 12
                ),
                
                box(
                    width = 12,
                    div(h3("How It Works", align = "center")),
                    imageOutput("algo", height = 600, width = 1200),
                    h5(tags$em("Source: Algoritma Data Science Academy"), align ="center"),
                    tags$br(),
                    imageOutput("gif", height = 600, width = 1200),
                    tags$br(),
                    imageOutput("dl", height = 400, width = 1200)
                ),
                
                box(
                    div(h3("Model Accuracy", align = "center")),
                    imageOutput("plot", height = 1000, width = 1500),
                    width = 9,
                    height = 600
                ),
                
                box(
                    width = 3,
                    height = 600,
                    tags$p(align= "justify",
                           tags$br(),
                           tags$br(),
                           tags$br(),
                           tags$br(),
                           tags$br(),
                           tags$br(),
                           h4("Dari hasil plot disamping terlihat bahwa akurasi di dapat adalah 81%.", align = "justify"),
                           tags$br(),
                           h4("Hasil tersebut didapat dari fungsi aktivasi softmax. Dibandingkan dengan fungsi aktivasi sigmoid yang hanya menghasilkan sekitar 78%.",
                              align = "justify"),
                           tags$br(),
                           h4("Hal ini membuat model dari mesin ini masih ada 20% error dan peran manusia sebagai pengambil keputusan akhir masih sangat diperlukan.",
                              align = "justify")
                    )
                    
                ),
                
                box(
                    width = 12,
                    div(h3("Defect Category", align = "center")),
                    tags$br(),
                    box(
                        width = 12,
                        imageOutput("defect1"),
                        h4("Category 1", align = "center")
                    ),
                    box(
                        width = 12,
                        imageOutput("defect2"),
                        h4("Category 2", align = "center")
                    ),
                    box(
                        width = 12,
                        imageOutput("defect3"),
                        h4("Category 3", align = "center")
                    ),
                    box(
                        width = 12,
                        imageOutput("defect4"),
                        h4("Category 4", align = "center")
                    )

                )
            )


        ),


        tabItem(
            tabName = "test",
            fluidPage(
                box(
                    width = 12,
                    h4("How to Use:"),
                    tags$br(),
                    tags$p("1. Take a picture of steel defect surface"),
                    tags$p("2. Make sure your image format is in (.jpg / .jpeg / .png)"),
                    tags$p("3. Upload image with menu on below"),
                    tags$br(),
                    tags$i("You can visit Datasets tab in the left and download test folder datasets from my github.")
                )
            ),

            fluidPage(
                theme = "#3e4142",
                box(width = 12,
                    fileInput("input_image","File", accept = c('.jpg','.jpeg', '.png'), multiple = F),
                    h5("Upload the image here"),
                    h6("(.jpg/.jpeg/.png format only)")
                )
            ),

            fluidPage(
                box(h4("Image:"),
                    imageOutput("output_image"),
                    width=9,
                    height = 600),

                box(h4("Class of Defect:"),
                    h2(textOutput("text"), align = "center"),
                    width=3,
                    height = 100),

                box(h4("Probability:"),
                    tags$br(),
                    h3(tableOutput("table"), align = "center"),
                    width = 3,
                    height = 480)
            )
        )
    )
)









#full page
#page definition
dashboardPage(
    header = header,
    sidebar = sidebar,
    body = body
)
