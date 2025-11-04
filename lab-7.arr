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

# Depth of the Deepest Sensor
fun deepest-depth(n :: SensorNet) -> Number:
  cases (SensorNet) n:
    | sensor(rate) => 0
    | hub(bandwidth, left, right) =>
        1 + num-max(deepest-depth(left), deepest-depth(right))
  end
end
check:
  deepest-depth(sA) is 0
  deepest-depth(hub1) is 1   # sensors are one level below
  deepest-depth(core) is 2   # sensors under hub1 are two levels below root
end

# Apply a Scaling Factor
fun needed-scale(n :: SensorNet) -> Number:
  cases (SensorNet) n:
    | sensor(rate) => 1
    | hub(bw, l, r) =>
        block:
          load = total-load(l) + total-load(r)
          here = load / bw
          num-max(num-max(here, needed-scale(l)), needed-scale(r))
        end
  end
end

fun apply-scale(n :: SensorNet, s :: Number) -> SensorNet:
  cases (SensorNet) n:
    | sensor(rate) => sensor(rate / s)
    | hub(bandwidth, left, right) =>
        hub(bandwidth, apply-scale(left, s), apply-scale(right, s))
  end
end
check:
  # Scaling manually by 1.2
  scaled-core = apply-scale(core, 1.2)
  total-load(core) is 225
  total-load(scaled-core) is 187.5

  # Check structure unchanged but scaled rates
  fits-capacities(scaled-core) is true

  # Using helper function
  needed-scale(core) is 1.2
  scaled-auto = apply-scale(core, needed-scale(core))
  fits-capacities(scaled-auto) is true
end

# Scale Network Just Enough to Make It Feasible
fun scale-to-fit(n :: SensorNet) -> SensorNet:
  s = needed-scale(n)
  if s <= 1:
    n
  else:
    apply-scale(n, s)
  end
end
check:
  # Needed scale for core is 1.2
  needed-scale(core) is 1.2

  # Automatically scale to make it feasible
  scaled-fit = scale-to-fit(core)

  # Check that it now fits capacities
  fits-capacities(scaled-fit) is true

  # Total load should be 225 / 1.2 = 187.5
  total-load(scaled-fit) is 187.5

  # Check a network that is already feasible
  goodHub1 = hub(200, sA, sB)
  goodCore = hub(250, goodHub1, sC)
  scale-to-fit(goodCore) is goodCore   # already fits, unchanged
end