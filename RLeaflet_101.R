### Les bases de la cartographie dynamique avec R et leaflet ###
### Code associé à l'article de blog : http://www.dacta.fr/blog/cartographie-r-leaflet.html ###

library(leaflet)


## Les bases ##

# Hello world !

m <- leaflet() %>% addTiles()
m

# Coucou Nantes

m <- leaflet() %>% addTiles() %>% 
      setView(lng = -1.5533600, lat = 47.2172500, zoom = 10) 
m

# Zoom sur la Tour Eiffel

m <- leaflet() %>% addTiles() %>% 
      setView(lng = 2.292551, lat = 48.858255, zoom = 16) 
m


## Ajouter des points ##

# Marquer la Tour Eiffel

m <- leaflet() %>%
      addTiles() %>%
      setView(lng = 2.292551, lat = 48.858255, zoom = 16) %>%
      addMarkers(lng = 2.2945, lat = 48.858255, popup = "La Tour Eiffel")
m

# Personnaliser le descriptif

description <- paste(sep = "<br/>",
                     "<b>La Tour Eiffel</b>",
                     "Paris, France",
                     "<img src='http://www.toureiffel.paris/images/galerie/photos/06_Tour-de-jour-rapprochee-SETE-Photographe-Bertrand-Michau.jpg' height='40' width='50'>",
                     "<a href='http://www.toureiffel.paris/'>Voir le site </a>")

m <- leaflet() %>%
  addTiles() %>%
  setView(lng = 2.292551, lat = 48.858255, zoom = 16) %>%
  addMarkers(lng = 2.2945, lat = 48.858255, popup = description)
m

# Changer l'icône

EiffelTower <- makeIcon(
  iconUrl = "img/eiffel-tower.png",
  iconWidth = 40, iconHeight = 40)

m <- leaflet() %>%
  addTiles() %>%
  setView(lng = 2.292551, lat = 48.858255, zoom = 16) %>%
  addMarkers(lng = 2.2945, lat = 48.858255, popup="La Tour Eiffel", icon = EiffelTower)
m

# Représenter plusieurs points à la fois

points <- data.frame(longitudes = c(-1.5640409999999747, -1.5582119000000603, -1.5462400000000116),
                     latitudes = c(47.205581, 47.217589, 47.21545),
                     labels = c("Elephant", "Tour de Bretagne", "Tour Lu"))

m <- leaflet(points) %>%
  addTiles() %>%
  setView(lng = -1.5533600, lat = 47.2172500, zoom = 12)  %>%
  addMarkers(lng = ~longitudes, lat = ~latitudes, popup = ~labels)
m


## Représenter d'autres formes sur une carte ##

villes <- data.frame(Ville = c("Paris", "Lille", "Nantes", "Marseille"),
                     Latitude = c(48.85661400000001, 50.62924999999999, 47.218371, 43.296482),
                     Longitude = c(2.3522219000000177, 3.057256000000052, -1.553621000000021, 5.369779999999992),
                     Population = c(2249975, 227560, 284970, 850726))


m <- leaflet(villes) %>% addTiles() %>%
                         addCircles(lng = ~Longitude, lat = ~Latitude, weight = 1,
                                    radius = ~sqrt(Population) * 50, popup = ~paste(Ville, ":", Population),
                                    color = "#a500a5", fillOpacity = 0.5)
m

# Changer les couleurs

couleurs <- colorNumeric("YlOrRd", villes$Population, n = 5)

m <- leaflet(villes) %>% addTiles() %>%
                         addCircles(lng = ~Longitude, lat = ~Latitude, weight = 1,
                                    radius = ~sqrt(Population) * 50, 
                                    popup = ~paste(Ville, ":", Population),
                                    color = ~couleurs(Population), fillOpacity = 0.9)
m

# Ajouter une légende

m <- leaflet(villes) %>% addTiles() %>%
                         addCircles(lng = ~Longitude, lat = ~Latitude, weight = 1,
                                    radius = ~sqrt(Population) * 50, 
                                    popup = ~paste(Ville, ":", Population),
                                    color = ~couleurs(Population), fillOpacity = 0.9) %>%
                         addLegend(pal = couleurs, values = ~Population, opacity = 0.9)

m
