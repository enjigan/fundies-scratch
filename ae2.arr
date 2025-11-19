use context dcic2024
# include csv
# penguins-table = load-table:
# species :: String,
# island :: String,
# bill_length_mm :: Number,
# bill_depth_mm :: Number,
# flipper_length_mm :: Number,
# body_mass_g :: Number,
# sex :: String
# source: csv-table-file("penguins.csv", default-options)
# end

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
  max-flipper-length([list: 180, 195, 210]) is 210
  max-flipper-length([list: 220, 232, 228]) is 232
end

fun convert-bodymass(masses :: List<Number>) -> List<Number>:
doc: "Transforms all masses from grams to kilograms by dividing each by 1000."
map(lam(m): m / 1000 end, masses)
where:
convert-bodymass([list: 3600, 4500, 5000]) is [list: 3.6, 4.5, 5.0]
convert-bodymass([list: 3800]) is [list: 3.8]
end


fun select-long-bills(penguins :: List<{bill_length_mm :: Number}>) -> List<{bill_length_mm :: Number}>:
  doc: "Selects penguin records whose bill_length_mm > 45"
  filter(lam(p):p.bill_length_mm > 45 end, penguins)
where:
  select-long-bills([list: { bill_length_mm: 40 }, { bill_length_mm: 49 }, { bill_length_mm: 47 }]) is [list: { bill_length_mm: 49 }, { bill_length_mm: 47 }]
end

fun count-adelie(penguins :: List<{species :: String}>) -> Number:
  cases (List) penguins:
    | empty => 0
    | link(first, rest) =>
      if first.species == "Adelie":
        1 + count-adelie(rest)
      else:
        count-adelie(rest)
      end
  end
where:
  count-adelie([list: {species: "Adelie"}, {species: "Gentoo"}, {species: "Adelie"}]) is 2
  count-adelie([list: { species: "Chinstrap" }]) is 0
end

