use context starter2024
fun is-leap-year(year :: Number) -> Boolean:
  doc: "Return true if the given year is a leap year, otherwise false"
  if num-modulo(year, 400) == 0:
    true
  else if num-modulo(year, 100) == 0:
    false
  else if num-modulo(year, 4) == 0:
    true
  else:
    false
  end
where:
  is-leap-year(2000) is true     
  is-leap-year(1900) is false  
  is-leap-year(2024) is true  
  is-leap-year(2023) is false 
end