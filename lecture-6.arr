use context starter2024
# A temperature is one of: celcius(degrees :: Number), fahrenheit(degrees :: Number), kelvin(degrees :: Number) 
# It represents a temperature value in a specific unit.

data Temperature:
  | celcius(degrees :: Number)
  | fahrenheit(degrees :: Number)
  | kelvin(degrees :: Number)
end

# to-celcius: Temperature -> Number 
# Converts any Temperature to degrees Celcius.
fun to-celcius(temp :: Temperature) -> Number:
  cases (Temperature) temp:
    | celcius(d) => d
    | fahrenheit(d) => (5/9) * (d - 32)
    | kelvin(d) => d - 273.15
  end
where:
  to-celcius(celcius(25)) is 25
  to-celcius(fahrenheit(32)) is 0
  to-celcius(kelvin(300)) is 26.85
end

# A Status is one of: todo, in-progress, done
# It represents the current progress state of a task.

data Status:
  | todo
  | in-progress
  | done
end

# A Task is one of: task(name :: String, priority :: Number, due-date :: String, status :: Status)
# It represents a single to-do task
data Task:
  | task(name :: String, priority :: Number, due-date :: String, status :: Status)
end

# describe: Task -> String
# Returns a readable description of a Task.
fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(name, priority, due-date, status) => "Task: " + name + ", Priority: " + num-to-string(priority) + ", Due: " + due-date + ", Status: " + status-to-string(status)
  end
where:
  describe(task("Buy milk", 1, "2025-10-20", todo)) is "Task: Buy milk, Priority: 1, Due: 2025-10-20, Status: todo"
  describe(task("Finish project", 2, "2025-10-25", in-progress)) is "Task: Finish project, Priority: 2, Due: 2025-10-25, Status: in-progress"
  describe(task("Submit report", 3, "2025-10-15", done)) is "Task: Submit report, Priority: 3, Due: 2025-10-15, Status: done"
end

fun status-to-string(s :: Status) -> String:
  cases (Status) s:
    | todo => "todo"
    | in-progress => "in-progress"
    | done => "done"
  end
end

# A WeatherReport is one of: sunny(temperature :: Number), rainy(temperature :: Number, precipitation :: Number), snowy(temperature :: Number, precipitation :: Number, wind-speed :: Number)
# It represents weather conditions with temperature, precipitation, and wind data.

data WeatherReport:
  | sunny(temperature :: Number)
  | rainy(temperature :: Number, precipitation :: Number)
  | snowy(temperature :: Number, precipitation :: Number, wind-speed :: Number)
end

# is-severe: WeatherReport -> Boolean
# Returns true if the weather is considered severe. 
fun is-severe(w :: WeatherReport) -> Boolean:
  cases (WeatherReport) w:
    | sunny(temp) => temp > 35
    | rainy(temp, precip) => precip > 20
    | snowy(temp, precip, wind) => wind > 30
  end
where:
  is-severe(sunny(36)) is true
  is-severe(rainy(22,10)) is false
  is-severe(snowy(-5, 15, 40)) is true
end


