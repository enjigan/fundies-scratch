use context dcic2024
include csv
include tables
include lists
include string-dict

penguins_table = load-table:
  num :: Number,
  species :: String,
  island :: String,
  bill_length_mm :: String, 
  bill_depth_mm :: String,
  flipper_length_mm :: String, 
  body_mass_g :: String, 
  sex :: String, 
  year :: Number
  source: csv-table-file("penguins.csv.csv", default-options)
end

dataset-records = penguins_table.all-rows()

# Scalar Processing
fun get-flipper-length(record):
  doc: "Extracts flipper length as a number from dataset"
  string-to-number(record["flipper_length_mm"]).or-else(0)
end

check:
  get-flipper-length([string-dict: "flipper_length_mm", "200.0"]) is 200
  get-flipper-length([string-dict: "flipper_length_mm", "185.5"]) is 185.5
  get-flipper-length([string-dict: "flipper_length_mm", ""]) is 0
end

fun calculate-average(num-list):
  doc: "Calculates the average of a list of numbers"
  total = fold(lam(acc, n): acc + n end, 0, num-list)
  num-to-roughnum(total) / length(num-list)
end

check:
  calculate-average([list: 10, 20, 30]) is%(within(0.01)) 20
  calculate-average([list: 5, 5, 5, 5]) is%(within(0.01)) 5
  calculate-average([list: 100]) is%(within(0.01)) 100
end

flipper-lengths = map(get-flipper-length, dataset-records)
average-flipper-length = calculate-average(flipper-lengths)

"Average flipper length: " + num-to-string-digits(average-flipper-length, 2) + "mm"



# Transformation
fun grams-to-kilograms(record):
  doc: "Converts body mass from grams to kilograms for a single record"
  mass-g = string-to-number(record["body_mass_g"]).or-else(0)
  mass-g / 1000
end

check:
  grams-to-kilograms([string-dict: "body_mass_g", "5000"]) is 5
  grams-to-kilograms([string-dict: "body_mass_g", "3750"]) is 3.75
  grams-to-kilograms([string-dict: "body_mass_g", "1000"]) is 1
  grams-to-kilograms([string-dict: "body_mass_g", ""]) is 0
end

masses-in-kg = map(grams-to-kilograms, dataset-records)

masses-in-kg.take(10)

# Selection
fun has-long-bill(record) -> Boolean:
  doc: "Checks if penguin has bill length greater than 50mm"
  bill-length = string-to-number(record["bill_length_mm"]).or-else(0)
  bill-length > 50
end

check:
  has-long-bill([string-dict: "bill_length_mm", "55.0"]) is true
  has-long-bill([string-dict: "bill_length_mm", "50.1"]) is true
  has-long-bill([string-dict: "bill_length_mm", "50.0"]) is false
  has-long-bill([string-dict: "bill_length_mm", "45.0"]) is false
  has-long-bill([string-dict: "bill_length_mm", ""]) is false
end

long-bill-penguins = filter(has-long-bill, dataset-records)

"Number of penguins with bill > 50mm: " + num-to-string(length(long-bill-penguins))

# Accumulation
fun sum-flipper-lengths(record-list):
  doc: "Sums all flipper lengths from a list of records"
  fold(
    lam(acc, r): 
      acc + string-to-number(r["flipper_length_mm"]).or-else(0) 
    end, 
    0, 
    record-list)
end

check:
  sum-flipper-lengths([list: 
      [string-dict: "flipper_length_mm", "100"],
      [string-dict: "flipper_length_mm", "200"]]) is 300
  sum-flipper-lengths([list: 
      [string-dict: "flipper_length_mm", "150"],
      [string-dict: "flipper_length_mm", "150"],
      [string-dict: "flipper_length_mm", "150"]]) is 450
  sum-flipper-lengths(empty) is 0
end

total-flipper-sum = sum-flipper-lengths(dataset-records)

"Sum of all flipper lengths: " + num-to-string(total-flipper-sum) + "mm"
