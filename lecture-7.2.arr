use context starter2024
# Counts how many individual stream feed into a river network.
# Scalar problem
data River:
  | stream(name :: String)
  | merge(left :: River, right :: River)
end

  fun count-streams(r :: River) -> Number:
  cases (River) r:
    | stream(name) => 1
    | merge(left, right) => count-streams(left) + count-streams(right)
  end
end

s1 = stream("A")
s2 = stream("B")
s3 = stream("C")

r1 = merge(s1, s2)
r2 = merge(r1, s3)

check:
  count-streams(s1) is 1
  count-streams(r1) is 2
  count-streams(r2) is 3
end