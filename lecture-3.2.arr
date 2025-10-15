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

plants.length()

#plants.row-n(105)

#plants["not_a_column"] 

glucose = load-table:
  patient_id :: String,
  glucose_level :: Number,
  date_time :: Number,
  insulin_dose :: Number,
  exercise_duration :: Number,
  stress_ :: Number
  source: csv-table-file("glucose_levels.csv", default-options)
    
  sanitize glucose_level using num-sanitizer
  sanitize date_time using num-sanitizer
  sanitize insulin_dose using num-sanitizer
  sanitize exercise_duration using num-sanitizer
  sanitize stress_ using num-sanitizer
end