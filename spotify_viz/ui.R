# ui for spotify viz Shiny app


shinyUI(dashboardPage(
  dashboardHeader(title='Spotify Artists'),

  dashboardSidebar( sidebarUserPanel("Spotify",
                                     image = './Spotify_Icon_RGB_Green.png' ),
                    sidebarMenu(
#                        menuItem("Map", tabName = "map", icon = "map")
                        menuItem("Plots", tabName = "plots", icon = icon("bar-chart-o")),
                        menuItem("Data", tabName = "data", icon = icon("database"))
                        ),
                    
#                    selectizeInput(inputId='origin', label='US Artist',
#                                   choices=unique(artists$origin),
#                                   selected=unique(artists$origin)[1]),
                    selectizeInput("foreign", "Foreign Market",
                                   choices=unique(artists$foreign))
  ),
  
  dashboardBody(
      tabItems(
          tabItem(tabName = 'plots', fluidRow(
            column(5, plotOutput("count")),
            column(7, plotOutpit("delay")) )),
          
          tabItem(tabName = 'data', DTOutput("table")) )
  )
))