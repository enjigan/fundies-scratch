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

fun tick(sec :: Number) -> Number:
  doc: "Return the next second value on a clock. Valid input is an integer 0-59."
  if sec == 59:
    0
  else if (sec >= 0) and (sec < 59) and (sec == num-truncate(sec)):
    sec + 1
  else:
    raise("Invalid input: seconds must be an integer between 0 and 59")
  end
where:
  check:
    tick(0) is 1       
    tick(1) is 2        
    tick(58) is 59      
    tick(59) is 0      
  end 
end