use context dcic2024
include csv
# Task 1
# Goal: Clean and prepare the flights_sample53.csv dataset by handling missing data, normalizing text and time formats, removing duplicates, and identifying potential outliers.
# Inputs: Columns from the dataset- flight, carrier, dep_time, arr_time, dep_delay, arr_delay, tailnum, origin, dest, distance
# Outputs: Cleaned table (no duplicates, no missing values, consistent formats),visualization (average delay by airline)
# Planned Steps:
# 1. Load the CSV dataset as a table using load-table with type annotations.
# 2. Replace missing tail numbers with "UNKNOWN".
# 3. Replace negative delay values (dep_delay, arr_delay) with 0.
# 4. Clean and normalize text fields (carrier → uppercase, trimmed).
# 5. Convert dep_time to consistent "HH:MM" format.
# 6. Create a new column called dedup_key by combining:
# flight + "-" + carrier + "-" + dep_time
# 7. Use group and count to find and display duplicates.
# 8. Save the cleaned table for later analysis and visualization
# Example Step:
# Problem: The 'carrier' column has inconsistent casing and extra spaces.
# Planned Step: Convert carrier text to uppercase and trim spaces.
# Implementation:transform-column(flights, "carrier", lam(c): string-to-upper(trim(c)))

# Load the CSV file with type annotations
flights_53 = load-table:
  year :: Number,
  month :: Number,
  day :: Number,
  dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String,
  distance :: Number
  source: csv-table-url("flights_sample53.csv", default-options)
end

# Task 2
# Trim spaces
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  string-replace(s, " ", "")
end

# Normalize carrier (uppercase + trim)
fun normalize-carrier(c :: String) -> String:
  doc: "Trim spaces and convert airline code to uppercase."
  string-to-upper(trim(c))
end

fun pad-left(s :: String, target-len :: Number) -> String:
  doc: "Adds leading zeros if the string is shorter than the desired length."
  if string-length(s) < target-len:
    "0" + s
  else:
    s
  end
end

# Convert dep_time (e.g., 517) → "05:17"
fun format-time(t :: Number) -> String:
  doc: "Convert numeric time (e.g., 517) to HH:MM string."
  hours = num-truncate(t / 100)
  mins = num-mod(t, 100)
  hh = pad-left(num-to-string(hours), 2, "0")
  mm = pad-left(num-to-string(mins), 2, "0")
  hh + ":" + mm
end

# Handle Missing Data
flights_filled = transform-column(flights_53, "tailnum", lam(t):
 if t == "":
  "UNKNOWN"
else:
  t
    end
end)

# Replace Negative Delay Values
# Replace negative departure delay values
flights_nonneg_dep = transform-column(flights_filled, "dep_delay", lam(d):
  if d < 0:
    0
  else:
    d
  end
end)

# Replace negative arrival delay values
flights_nonneg = transform-column(flights_nonneg_dep, "arr_delay", lam(d):
  if d < 0:
    0
  else:
    d
  end
end)

# Create dedup_key Column
flights_dedupkey = build-column(flights_nonneg, "dedup_key", lam(r):
  f = num-to-string(r["flight"])
  c = normalize-carrier(r["carrier"])
  t = format-time(r["dep_time"])
  f + "-" + c + "-" + t
  end)

# Identify duplicates
dup_counts = flights_dedupkey.group-by("dedup_key", count)
duplicates = dup_counts.filter(lam(r): r["count"] > 1 end)

# Cleaned table ready for analysis
clean_flights = flights_dedupkey

# Task 3
fun carrier-to-airline(code :: String) -> String:
  doc: "Maps a carrier code to the full airline name."
  c = string-to-upper(trim(code))  # normalize carrier code
  if c == "UA":
    "United Airlines"
  else if c == "AA":
    "American Airlines"
  else if c == "B6":
    "JetBlue"
  else if c == "DL":
    "Delta Air Lines"
  else if c == "EV":
    "ExpressJet"
  else if c == "WN":
    "Southwest Airlines"
  else if c == "OO":
    "SkyWest Airlines"
  else:
    "Other"
  end
end

# Add new airline column to the cleaned flights table
flights_with_airline = build-column(clean_flights, "airline", lam(r):
  carrier-to-airline(r["carrier"])
end)

# Filter out outliers
flights_no_outliers = filter-with(flights_with_airline, lam(r):
    (r["distance"] <= 5000) and (r["air_time"] >= 500)
end)

# Task 4