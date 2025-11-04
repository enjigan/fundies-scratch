use context starter2024
data SensorNet:
  | hub(bandwidth :: Number, left :: SensorNet, right :: SensorNet)
  | sensor(rate :: Number)
end

# Example network
sA = sensor(60)
sB = sensor(120)
sC = sensor(45)

# You can construct larger networks like:
hub1 = hub(150, sA, sB)
core = hub(200, hub1, sC)

# Compute Total Offered Load
fun total-load(n :: SensorNet) -> Number:
  cases (SensorNet) n:
    | sensor(rate) => rate
    | hub(bandwidth, left, right) => total-load(left) + total-load(right)
  end
end
check:
  total-load(sA) is 60
  total-load(sB) is 120
  total-load(sC) is 45
  total-load(hub1) is 180   # 60 + 120
  total-load(core) is 225   # 180 + 45
end