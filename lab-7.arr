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

# Check Capacity Feasibility
fun fits-capacities(n :: SensorNet) -> Boolean:
  cases (SensorNet) n:
    | sensor(rate) => true
    | hub(bandwidth, left, right) =>
        ((total-load(left) + total-load(right)) <= bandwidth)
        and fits-capacities(left)
        and fits-capacities(right)
  end
end
check:
  # hub1 = hub(150, sA, sB) → total load = 180, 150 < 180 → should be false
  fits-capacities(hub1) is false

  # core = hub(200, hub1, sC) → total load = 180 + 45 = 225, 200 < 225 → false
  fits-capacities(core) is false

  # Create a feasible network:
  goodHub1 = hub(200, sA, sB)   # 60 + 120 = 180 ≤ 200
  goodCore = hub(250, goodHub1, sC)  # 180 + 45 = 225 ≤ 250 → feasible
  fits-capacities(goodCore) is true
end