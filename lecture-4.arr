use context dcic2024
orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

fun is-morning(r :: Row) -> Boolean:
  doc: "checks if the time is morning"
  r["time"] < "12:00"
where:
  is-morning(orders.row-n(3)) is true
  is-morning(orders.row-n(5)) is false
end

filter-with(orders, is-morning)

filter-with(orders, lam(r): r["time"] < "12:00" end)

order-by(orders, "time", false)

latest-morning = order-by(filter-with(orders, is-morning), "time", false)

latest-morning-amount = latest-morning.row-n(0)["amount"]
check:
  latest-morning-amount is 3.95
end

