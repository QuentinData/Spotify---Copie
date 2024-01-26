#### Lecture des data
spotify_data <- read.csv("data/spotify-2023.csv", 
                         stringsAsFactors = FALSE,
                         check.names = FALSE, quote = "\"",
                         header = TRUE, 
                         encoding = "UTF-8") %>%
  
# Renommer la colonne artist(s)_name en artist_name (utilisé rename avec dyplyr)
rename(artist_name = 'artist(s)_name') %>%
  
# convertir les valeurs de la colonne streams en nombres
mutate(streams = as.numeric(as.character(streams)))

# Séparation des artistes : Les noms des artistes sont séparés s'ils sont listés ensemble dans une même chaîne de caractères.
spotify_data$artist_name <-  strsplit(spotify_data$artist_name, ", ")
spotify_data <-  tidyr::unnest(spotify_data, artist_name)
 
# Nettoyage supplémentaire et formatage : Suppression des espaces superflus dans les noms des artistes.
spotify_data$artist_name = trimws(spotify_data$artist_name, which = "both")


# Filtrage des artistes :  ne garder que les artistes ayant plus de 5 chansons.
data_artist <- spotify_data %>%
  group_by(artist_name) %>%
  summarise(nb = n()) %>%
  filter (nb > 4)

spotify_data <- spotify_data %>%
  filter(artist_name %in% data_artist$artist_name)


#### Définition genre de musique 
# https://www.kine-formations.com/wp-content/uploads/2020/04/Liste-des-BPM-par-style-musical-Annexe-t%C3%A9l%C3%A9chargeable-%C3%A0-la-fin.pdf

get_genre_by_bpm <- function(bpm) {
  case_when(
    bpm == 80 ~ "Crunk",
    bpm >= 60 & bpm <= 90 ~ "Dub",
    bpm >= 80 & bpm <= 90 ~ "Reggae",
    bpm >= 80 & bpm <= 100 ~ "Hip-hop",
    bpm >= 80 & bpm <= 120 ~ "Rock Folk",
    bpm >= 90 & bpm <= 120 ~ "Rock pop",
    bpm >= 50 & bpm <= 56 ~ "Tango",
    bpm >= 80 & bpm <= 100 ~ "Salsa",
    bpm >= 60 & bpm <= 120 ~ "Trip hop",
    bpm >= 70 & bpm <= 120 ~ "Soul Music",
    bpm >= 100 & bpm <= 120 ~ "Chillstep",
    bpm >= 120 & bpm <= 135 ~ "Minimal",
    bpm >= 125 & bpm <= 135 ~ "Funky house",
    bpm >= 126 & bpm <= 135 ~ "Electro",
    bpm >= 125 & bpm <= 140 ~ "House music",
    bpm >= 130 & bpm <= 140 ~ "Trance",
    bpm >= 135 & bpm <= 145 ~ "Dubstep",
    bpm >= 120 & bpm <= 150 ~ "Techno",
    bpm >= 170 & bpm <= 180 ~ "Rock Punk",
    bpm >= 150 & bpm <= 190 ~ "Drum’n’bass",
    bpm >= 60 & bpm <= 220 ~ "Jazz",
    bpm >= 80 & bpm <= 220 ~ "Rock",
    bpm >= 160 & bpm <= 230 ~ "Hardcore",
    bpm >= 200 & bpm <= 500 ~ "Speedcore",
    bpm > 1000 ~ "Extratone",
    TRUE ~ "Genre inconnu"
  )
}

spotify_data <- spotify_data %>%
  mutate(genre = get_genre_by_bpm(bpm))

#### Header application
dbHeader <- dashboardHeader()
dbHeader$children[[2]]$children <- tags$a(href='https://www.kaggle.com/datasets/nelgiriyewithana/top-spotify-songs-2023',
                                          tags$img(src='my_Logo.jpg',height='40',
                                                   width='130'))
