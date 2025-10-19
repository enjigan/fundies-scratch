use context starter2024
fun area(width :: Number, height :: Number) -> Number:
  # Computes the area of a rectangle given its width and height.

  # Parameters: width: The width of the rectangle (a Number). height: The height of the rectangle (a Number).

  # Returns: The area of the rectangle as a Number.
  
  width * height
end

4 * (5 + (0.10 * string-length("Go Team!")))

7 * (5 + (0.10 * string-length("Hello World")))

Base-cost = 5
Char-cost = 0.10

fun tshirt-cost(num-shirts :: Number, message :: String) -> Number:

  # Calculates the total cost of printing a given number of t-shirts with a custom message.

  # Each shirt costs a base price of £5.00 plus an additional £0.10 per character in the message.

  # Parameters: num-shirts: The number of t-shirts to be printed. message: The text to be printed on each shirt.

  # Returns: The total cost for all the t-shirts as a Number.
  
  num-shirts * (Base-cost + (Char-cost * string-length(message)))
end
check:
  tshirt-cost(4, "Go Team!") is 4 * (5 + (0.10 * string-length("Go Team!")))
  tshirt-cost(7, "Hello World") is 7 * (5 + (0.10 * string-length("Hello World")))
end


fun celsius-to-fahrenheit(celsius :: Number) -> Number:
  
  # Converts a temperature from degrees Celsius to degrees Fahrenheit.

  # The conversion uses the formula: Fahrenheit = (Celsius * 9/5) + 32

  # Parameters: celsius: The temperature in degrees Celsius.

  # Returns: The equivalent temperature in degrees Fahrenheit.

  (celsius * (9/5)) + 32
end

fun fahrenheit-to-celsius(fahrenheit :: Number) -> Number:

  # Converts a temperature from degrees Fahrenheit to degrees Celsius.

  # The conversion uses the formula: Celsius = (Fahrenheit - 32) * 5/9

  # Parameters: fahrenheit: The temperature in degrees Fahrenheit.

  # Returns: The equivalent temperature in degrees Celsius.

  (fahrenheit - 32) * (5/9)
end

check:
  celsius-to-fahrenheit(0) is 32
  celsius-to-fahrenheit(100) is 212
  celsius-to-fahrenheit(-40) is -40

  fahrenheit-to-celsius(32) is 0
  fahrenheit-to-celsius(212) is 100
  fahrenheit-to-celsius(-40) is -40
end