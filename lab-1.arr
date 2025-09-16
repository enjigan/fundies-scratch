use context starter2024
3 + (5 * 12)
3 + (7 * 12)

perimeter = 2 * (420 + 594)
cost = perimeter * 0.10

"Designs for everyone!"

"red" + "blue"

image1 = overlay-align("center", "top", circle(15, "solid", "red"), rectangle(45, 110, "solid", "black"))

image2 = overlay-align("center", "middle", circle(15, "solid", "yellow"), image1)

overlay-align("center", "bottom", circle(15, "solid", "green"), image2)

rectangle(50, 20, "solid", "black")
circle(30, "solid", "red")

flag1 = overlay-align("left", "top", rectangle(20, 20, "solid", "red"), rectangle(100, 50, "solid", "pink"))

flag2 = overlay-align("right", "middle", rectangle(10, 50, "solid", "red"), flag1)

symbol = overlay(star(20, "solid", "yellow"),rotate(45, square(25, "solid", "red")))

overlay-align("center", "middle", symbol, flag2)
  