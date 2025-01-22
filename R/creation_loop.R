library(dplyr)
library(htmlwidgets)
library(leaflet)
library(sf)

data_version = "20250121"

tsunami = read_sf(paste0("data/manta_pet_tsunami_", data_version, ".geojson"))

rutas = read_sf(paste0("data/manta_pet_rutas_", data_version, ".geojson"))

zonas = read_sf(paste0("data/manta_pet_zonas_", data_version, ".geojson")) |> st_centroid()

zonas_icon = list(iconUrl = "data/zs.png", iconSize = c(33, 33))

puntos = read_sf(paste0("data/manta_pet_puntos_", data_version, ".geojson"))

puntos_icon = list(iconUrl = "data/pe.png", iconSize = c(20, 20))

parroquias = c("Manta", "Tarqui", "Los Esteros", "San Mateo", "Santa Marianita", "San Lorenzo")

parroquias_center = c(
   c(-80.723, -0.951),
   c(-80.716, -0.955),
   c(-80.698, -0.952),
   c(-80.811, -0.959),
   c(-80.848, -0.990),
   c(-80.907, -1.066)
) |> matrix(dimnames = list(1:2, parroquias), nrow = 2)

for(target_parroquia in parroquias) {
   source("R/map_creation.R")
}
