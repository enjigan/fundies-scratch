use context starter2024
include csv

plants = load-table:
  plant_common_name :: String,
  location_latitude :: Number,
  location_longitude :: Number,
  date_sighted :: Number,
  soil_type :: String,
  plant_height_cm :: Number,
  plant_color :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
end

plants.row-n(1)
plants.row-n(5)
