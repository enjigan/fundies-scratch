use context starter2024
# Contract:
# tick :: Number -> Number
# Purpose:
# Given a valid second (0-59), return the next second as if a clock were ticking.
# If given 59, return 0
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

# Contract:
# tick :: Number -> Number
# Purpose:
# Given a valid second (0-59), return the next second as if a clock were ticking.
# If given 59, return 0
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

# Contract:
# rock-paper-scissors :: String, String -> String
# Purpose:
# Given the choices of player 1 and player 2 (each must be exactly the lowercase string "rock", "paper", or "scissors"), return:
# - "player 1"        when player 1 wins,
# - "player 2"        when player 2 wins,
# - "tie"             when both choices are the same,
# - "invalid choice"  if either input is not one of the three allowed strings.
fun rock-paper-scissors(p1 :: String, p2 :: String) -> String:
  doc: "Decide the winner of Rock-Paper-Scissors. Inputs must be exactly 'rock', 'paper', or 'scissors' (lowercase). Returns player 1, player 2, tie, or invalid choice."

  if (p1 == p2):
    "tie"
  else if ( ((p1 == "rock") and (p2 == "scissors"))
            or ((p1 == "paper") and (p2 == "rock"))
            or ((p1 == "scissors") and (p2 == "paper")) ):
    "player 1"
  else if ( ((p2 == "rock") and (p1 == "scissors"))
      or ((p2 == "paper") and (p1 == "rock"))
      or ((p2 == "scissors") and (p1 == "paper")) ):
    "player 2"
  else:
    "invalid choice"
  end
where:
  check:
    rock-paper-scissors("rock", "scissors") is "player 1"
    rock-paper-scissors("paper", "rock") is "player 1"
    rock-paper-scissors("scissors", "paper") is "player 1"

    rock-paper-scissors("scissors", "rock") is "player 2"
    rock-paper-scissors("rock", "paper") is "player 2"
    rock-paper-scissors("paper", "scissors") is "player 2"

    rock-paper-scissors("rock", "rock") is "tie"
    rock-paper-scissors("paper", "paper") is "tie"
    rock-paper-scissors("scissors", "scissors") is "tie"
    
    rock-paper-scissors("rock", "dog") is "invalid choice"
    rock-paper-scissors("Rock", "scissors") is "invalid choice"
  end
end

planets = table: Planet, Distance
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end

mars = planets.row-n(3)

mars-distance = planets.row-n(3)["Distance"]

  check:
    mars-distance is 1.52
  end
