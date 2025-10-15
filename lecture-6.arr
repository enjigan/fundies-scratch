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


