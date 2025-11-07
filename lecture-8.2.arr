use context starter2024
fun fact(n):
  ask:
    | n == 1 then: 1
    | otherwise: n * fact(n - 1)
  end
where:
  fact(3) is 6
end
