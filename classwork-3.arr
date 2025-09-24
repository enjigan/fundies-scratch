use context starter2024
fun choose-hat(temp-in-C :: Number) -> String:
  doc: "determines appropriate head gear: below 10C a winter hat, 27C or above a sun hat, otherwise no hat"
  if temp-in-C < 10:
    "winter hat"
  else if temp-in-C >= 27:
    "sun hat"
  else:
    "no hat"
  end
where:
    choose-hat(5)  is "winter hat"
  choose-hat(25) is "no hat"
  choose-hat(27) is "sun hat"
  choose-hat(32) is "sun hat"
end
