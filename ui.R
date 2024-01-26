base::source("packages.R")
base::source("global.r")

ui <- dashboardPage(skin = "black",
                    dbHeader,
                    dashboardSidebar(disable = TRUE),
                    dashboardBody(
                      box(
                        title = "Important informations",
                        status = "success",
                        background = "olive",
                        solidHeader = TRUE,
                        width = 12,
                        p("This dashboard presents summarized data for one or multiple artists."),
                        p("Note : Only artist with at least 5 songs are inclued in the analysis")
                      ),
                      box(
                        title = "Artist",
                        solidHeader = FALSE, 
                        width = 6,
                        column(3, align = "center"),
                        column(6, align = "center"),
                        column(3, align = "center"),
                        pickerInput("Selected_artist",
                                    #label = "Default", 
                                    choices = sort(unique(spotify_data$artist_name)),
                                    multiple = TRUE)
                      ),
                      box(
                        title = "Chat with ChatGPT",
                        solidHeader = FALSE, 
                        width = 6,
                        column(3, align = "center"),
                        column(6, align = "center"),
                        column(3, align = "center")
                      ),
                      box(
                        title = "Stats",
                        solidHeader = FALSE,
                        width = 6,
                        valueBoxOutput("numStreams"),
                        br(),
                        fluidRow(
                        )
                      ),
                      br(), 
                      box(title = "Track & playlist presence", 
                          
                      )
                      
                    )
)

