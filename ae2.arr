use context dcic2024
include csv
include data-source
include lists

penguins_tables = load-table:
  num :: Number,
  species :: String,
  island :: String,
  bill_length_mm :: Number, 
  bill_depth_mm :: Number,
  flipper_length_mm :: Number, 
  body_mass_g :: Number, 
  sex :: String, 
  year :: Number
  source: csv-table-file("penguins.csv.csv", default-options)
end

# Scalar Processing
fun max-flipper-length(flippers :: List<Number>) -> Number:
  doc: "Returns the maximum flipper length from a non-empty list"
  cases (List) flippers:
    | empty => raise("List cannot be empty")
    | link(first, rest) =>
      fun helper(current-max, lst):
        cases (List) lst:
          | empty => current-max
          | link(f, r) =>
            if f > current-max:
              helper(f, r)
            else:
              helper(current-max, r)
            end
        end
      end
      helper(first, rest)
  end
where:
  max-flipper-length([list: 180.0, 195.0, 210.0]) is 210.0
  max-flipper-length([list: 220.0, 232.0, 228.0]) is 232.0
end

# Transformation
fun convert-bodymass-kg(masses :: List<Number>) -> List<Number>:
  doc: "Transforms all masses from grams to kilograms by dividing each by 1000."
  map(lam(m): m / 1000 end, masses)
where:
  convert-bodymass-kg([list: 3600.0, 4500.0, 5000.0]) is [list: 3.6, 4.5, 5.0]
  convert-bodymass-kg([list: 3800.0]) is [list: 3.8]
end

# Selection
fun select-long-bills(penguins :: List<{bill_length_mm :: Number}>) -> List<{bill_length_mm :: Number}>:
  doc: "Selects penguin records whose bill_length_mm > 45"
  filter(
    lam(p):
      p.bill_length_mm > 45.0
    end,
    penguins
  )
where:
  select-long-bills(
    [list:
      { bill_length_mm: 40.0 },
      { bill_length_mm: 49.0 },
      { bill_length_mm: 47.0 }
    ]
  )
  is
  [list:
    { bill_length_mm: 49.0 },
    { bill_length_mm: 47.0 }
  ]
end

# Accumulation
fun count-adelie(penguins :: List<{species :: String}>) -> Number:
  doc: "Counts how many penguin records in the list have species 'Adelie'"
  fun helper(num, lst):
    cases (List) lst:
      | empty => num
      | link(p, rest) =>
        if p.species == "Adelie":
          helper(num + 1, rest)
        else:
          helper(num, rest)
        end
    end
  end
  helper(0, penguins)
where:
  count-adelie(
    [list:
      { species: "Adelie" },
      { species: "Gentoo" },
      { species: "Adelie" }
    ]
  ) is 2

  count-adelie([list: { species: "Chinstrap" }]) is 0
end
