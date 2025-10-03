use context dcic2024

items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

fun ten-percent(c :: Number) -> Number: 
  doc: "finds x value when 10% closer"
c * 0.9
end 

closer-x-items = transform-column(items, "x-coordinate", ten-percent)

closer-y-items = transform-column(closer-x-items, "y-coordinate", ten-percent)

fun calc-distance(r :: Row) -> Number:
  num-round(num-sqrt(num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"])))
end

items-with-dist = build-column(items, "distance", calc-distance)

sorted-by-distance = order-by(items-with-dist, "distance", true)
  
closest-item = sorted-by-distance.row-n(0)["item"]

fun obfuscate-name(name :: String) -> String:
  string-repeat("X", string-length(name))
  where:
  obfuscate-name("Sword of Dawn") is "XXXXXXXXXXXXX"
  obfuscate-name("Orb") is "XXX"
end

obfuscated-items = transform-column(items, "item", obfuscate-name)

fun obfuscate-table(t :: Table) -> Table:
  transform-column(t, "item", obfuscate-name)
end

tiny =
  table: item
    row: "Axe"
    row: "Bow"
  end