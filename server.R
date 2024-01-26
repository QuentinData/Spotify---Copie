# Define the server logic
server <- function(input, output, session) {
  
  filtered_data <- reactive({
    spotify_data %>% filter(artist_name %in% input$artist_select)
  })
  
  # Calculate number of streams
  num_streams <- reactive({
    filtered_data()%>%
      summarize(n_streams = sum(streams)) %>%
      pull()
  })
  
  # Calculate number of tracks
  num_tracks <- reactive({
    
  })
  
  # Calculate number of artists
  num_artists <- reactive({
   
  })
  
  # Calculate number of genre
  num_genre <- reactive({
   
  })
  
  
  output$numStreams <- renderValueBox({
    valueBox(value = num_streams(), color = "olive", subtitle = "Number of streams")
  })
  
  output$numTracks <- renderValueBox({
  
  })
  
  
  output$numArtists <- renderValueBox({
  
  })
  
  
  output$numGenre <- renderValueBox({
    
  })
  
  
  output$datatable_track <- renderDT({
    data <- filtered_data() %>% 
      ...
    
    datatable(data, options = list(
      scrollX = TRUE,
      paginate = T,
      lengthMenu = c(5, 10, 15),
      pageLength = 20
    ))
    
  })
  
  output$tracksPerYearArtistPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      ...
    
    p <- ggplot()
    ...
      theme_minimal() 
    
    ggplotly(p)
    
  })
  
  # Render the interactive plotly plot
  output$genrePopularityPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      ...
    
    p <- ggplot()
    ...
    theme_minimal() 
    
    ggplotly(p)
    
  })
  
}





