use context starter2024
data River:
  | stream(name :: String)
  | merge(left :: River, right :: River)
end

# Counts how many individual stream feed into a river network.
# Scalar problem
fun count-streams(r :: River) -> Number:
  cases (River) r:
    | merge(left, right) => count-streams(left) + count-streams(right)
    | stream(name) => 1
  end
where:
  s1 = stream("A")
  s2 = stream("B")
  s3 = stream("C")

  merge1 = merge(s1, s2)
  main_river = merge(merge1, s3)

  count-streams(merge1) is 2
  count-streams(main_river) is 3
end

# Finds the maximum width among all merge points in a river network.
# Scalar problem 
#fun max-width(r :: River) -> Number:
#  cases (River) r:
#    | stream(name) => 0
#    | merge(left, right, width) =>
#        max-of([width, max-width(left), max-width(right)])
#  end
# where:
#  s1 = stream("A")
#  s2 = stream("B")
# s3 = stream("C")

# r1 = merge(s1, s2, 5)
# r2 = merge(r1, s3, 8)

# max-width(s1) is 0
# max-width(r1) is 5
# max-width(r2) is 8
# end
  