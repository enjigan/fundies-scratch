use context starter2024
circle(28, "solid", "red")

string-to-upper("hello cs2000!")

overlay(circle(25, "solid", "blue"),
  rectangle(35, 65, "solid", "yellow"))

overlay(rectangle(60,20 , "solid", "green"), rectangle(60, 35, "solid", "purple"))

rotate(10, rectangle(100, 20, "solid", "red"))
  rotate(-10, rectangle(100, 20, "solid", "red"))

above(
  beside(
    crop(40, 40, 40, 40, circle(40, "solid", "blue")),
    crop(0, 40, 40, 40, circle(40, "solid", "green"))),
  beside(
    crop(40, 0, 40, 40, circle(40, "solid", "green")),
    crop(0, 0, 40, 40, circle(40, "solid", "blue"))))

overlay(text("STOP", 24, "black"), regular-polygon(40, 8, "solid", "red"))
