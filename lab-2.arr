use context starter2024
import file("lab2-support.arr") as support
  
support.encryptor1("hello.")
fun my-encryptor1(s :: String) -> String:
  doc: "repeats a string five times"
  string-repeat(s,5)
end
support.test-encryptor1(my-encryptor1)

support.encryptor2("hello.")
fun myencryptor2(s :: String) -> String:
  doc: "returns the first four characters in a string"
  string-substring(s, 0, 4)
end
support.test-encryptor2(myencryptor2)

support.encryptor3("hello.")
fun my-encryptor3(s :: String) -> String:
  doc: "replaces . with !"
  string-replace(s, ".", "!")
end
support.test-encryptor3(my-encryptor3)

support.encryptor4("hello.")
fun my-encryptor4(s :: String) -> String:
  doc: "repeats the first four characters five times"
  string-repeat(string-substring(s,0,4),5)
end
support.test-encryptor4(my-encryptor4)

support.encryptor4("aeiouAEIOU")
fun my-encryptor5(s :: String) -> String:
  doc: "replaces lower and upper case vowels with the next letter in the alphabet"
  s1 = string-replace(s, "a", "b")
  s2 = string-replace(s1, "e", "f")
  s3 = string-replace(s2, "i", "j")
  s4 = string-replace(s3, "o", "p")
  s5 = string-replace(s4, "u", "v")
  s6 = string-replace(s5, "A", "B")
  s7 = string-replace(s6, "E", "F")
  s8 = string-replace(s7, "I", "J")
  s9 = string-replace(s8, "O", "P")
  string-replace(s9, "U", "V")
end
support.test-encryptor5(my-encryptor5)

support.encryptor6("Bright")
fun my-encryptor6(s :: String) -> String:
  doc: "lower cases and removes the character 'r' from a string"
  string-replace(string-to-lower(s), "r", "")
end
support.test-encryptor6(my-encryptor6)

support.encryptor7("Hello")
fun my-encryptor7(s :: String) -> Number:
   doc: "returns string length"
   string-length(s)
end
support.test-encryptor7(my-encryptor7)

support.encryptor8("Hello")
fun my-encryptor8(s :: String) -> String:
  doc: "returns string with !!! appended to the end repeated three times"
  string-repeat(s + "!!!", 3)
end
support.test-encryptor8(my-encryptor8)

support.encryptor9("Hello")
fun my-encryptor9(s :: String) -> Number:
  doc: "returns the code point of the first character"
  string-to-code-point(string-substring(s,0,1))
end
support.test-encryptor9(my-encryptor9)


support.encryptor10("Hello")
fun my-encryptor10(s :: String) -> String:   
  doc: "Applies my-encryptor5, then my-encryptor6, then my-encryptor4 in sequence."
  my-encryptor4(
    my-encryptor6(
      my-encryptor5(s)))
end
support.test-encryptor10(my-encryptor10)
