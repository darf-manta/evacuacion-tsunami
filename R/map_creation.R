library(htmlwidgets)
library(leaflet)
library(sf)

data_version = "20250121"
target_parroquia = c(manta = "Manta")

tsunami = read_sf(data_gpkg, "inocar2019_area_inundacion") |>
   st_zm() |> st_transform(4326) |> st_simplify(dTolerance = 5)

rutas = read_sf(paste0("data/manta_pet_rutas_", data_version, ".geojson")) |>
   filter(parroquia == target_parroquia)

zonas = read_sf(paste0("data/manta_pet_zonas_", data_version, ".geojson")) |>
   filter(parroquia == target_parroquia) |>
   st_centroid()

puntos = read_sf(paste0("data/manta_pet_puntos_", data_version, ".geojson")) |>
   filter(parroquia == target_parroquia)

zonas_icon = list(iconUrl = "data/zs.png", iconSize = c(33, 33))

puntos_icon = list(iconUrl = "data/pe.png", iconSize = c(20, 20))

target_map = leaflet(options = leafletOptions(minZoom = 14, maxZoom = 18)) |>
   setView(-80.723, -0.949, 16) |>
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
