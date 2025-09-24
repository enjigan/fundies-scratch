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

fun choose-hat-ask(temp-in-C :: Number) -> String:
  doc: "determines appropriate head gear: below 10C a winter hat, 27C or above a sun hat, otherwise no hat"
  ask:
    | temp-in-C < 10 then: "winter hat"
    | temp-in-C >= 27 then: "sun hat"
    | otherwise: "no hat"
  end
where:
  choose-hat-ask(5)  is "winter hat"
  choose-hat-ask(25) is "no hat"
  choose-hat-ask(27) is "sun hat"
  choose-hat-ask(32) is "sun hat"
end

fun add-glasses(outfit :: String) -> String:
  doc: "takes an outfit description and adds ', and glasses'"
  outfit + ", and glasses"
where:
  add-glasses("t-shirt") is "t-shirt, and glasses"
  add-glasses("pants") is "pants, and glasses"
end

fun choose-outfit(temp-in-C :: Number) -> String:
  doc: "chooses a hat based on the temperature and always adds glasses"
  add-glasses(choose-hat(temp-in-C))
where:
  choose-outfit(5)  is "winter hat, and glasses"
  choose-outfit(25) is "no hat, and glasses"
  choose-outfit(27) is "sun hat, and glasses"
end