library(htmlwidgets)
library(leaflet)
library(sf)

rutas_filter = filter(rutas, parroquia == target_parroquia)

zonas_filter = filter(zonas, parroquia == target_parroquia)

puntos_filter = filter(puntos, parroquia == target_parroquia)

target_map = leaflet(options = leafletOptions(minZoom = 14, maxZoom = 18)) |>
   setView(parroquias_center[1,target_parroquia], parroquias_center[2,target_parroquia], 16) |>
   setMaxBounds(-80.92, -1.14, -80.66, -0.92) |>
   addTiles('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png') |>
   addPolygons(data = tsunami, fillColor = "red", weight = 0) |>
   addPolylines(data = rutas, color = "red", weight = 4, opacity = 1) |>
   addPolylines(data = rutas, color = "yellow", weight = 3, opacity = 1) |>
   addMarkers(data = zonas, icon = zonas_icon) |>
   addMarkers(data = puntos, icon = puntos_icon)

target_map |> saveWidget(
   paste0("docs/parroquia-", names(target_parroquia), ".html"),
   title = paste("Mapa de rutas de evacuación ante Tsnami – Parroquia", target_parroquia),
   selfcontained = FALSE, libdir = "libs"
)
