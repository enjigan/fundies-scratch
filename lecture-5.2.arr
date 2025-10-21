use context starter2024
include lists
discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]

cleaned-codes =
  distinct(map(string-to-upper, discount-codes))

responses = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]

cleaned-responses =
  distinct(map(string-to-lower, responses))

definitive-responses =
  filter(lam(r): not(r == "maybe") end, cleaned-responses)

# 1. product
fun product(nums :: List<Number>) -> Number:

  #  Returns the product of all numbers in the list. If the list is empty, returns 1 (the identity for multiplication).
 fun product(nums :: List<Number>) -> Number:
  acc = 1
    for n from nums:
    acc := acc * n
  end
  acc
  end

# 2. sum-even-numbers
fun sum-even-numbers(nums :: List<Number>) -> Number:

  #  Returns the sum of all even numbers in the list. Odd numbers are ignored.

  total = 0
  for each n from nums:
    if num-modulo(n, 2) == 0:
      total := total + n
    end
  end
  total
end

# 3. my-length
fun my-length(lst :: List<Any>) -> Number:

  # Returns the number of elements in the given list.
  count = 0
  for each item from lst:
    count := count + 1
  end
  count
end

# 4. my-doubles (using loop)
fun my-doubles(nums :: List<Number>) -> List<Number>:

  # Returns a new list where each number is doubled. Implemented using a loop.

  result = []
  for each n from nums:
    result := link(result, [list: n * 2])
  end
  result
end

# 5. my-doubles-map (using map)
fun my-doubles-map(nums :: List<Number>) -> List<Number>:

  # Returns a new list where each number is doubled. Implemented using map from the lists library.
  map(lam(n): n * 2 end, nums)
end

# 6. my-string-lens (using loop)
fun my-string-lens(strings :: List<String>) -> List<Number>:

  # Returns a new list where each element is the length of the corresponding string. Implemented using a loop.

  result = []
  for each s from strings:
    result := link(result, [list: string-length(s)])
  end
  result
end

# 7. my-string-lens-map (using map)
fun my-string-lens-map(strings :: List<String>) -> List<Number>:

  # Returns a new list where each element is the length of the corresponding string. Implemented using map from the lists library.

  map(string-length, strings)
end



# 8. my-alternating
fun my-alternating(lst :: List<Any>) -> List<Any>:
  # Returns a new list containing every other element from the input list, starting with the first.

  result = []
  keep = true
  for each item from lst:
    if keep:
      result := link(result, [list: item])
    end
    keep := not(keep)
  end
  result
end
check:
  product([list: 2, 3, 4]) is 24
  sum-even-numbers([list: 1, 2, 3, 4, 5, 6]) is 12
  my-length([list: "a", "b", "c"]) is 3
  my-doubles([list: 1, 2, 3]) is [list: 2, 4, 6]
  my-doubles-map([list: 1, 2, 3]) is [list: 2, 4, 6]
  my-string-lens([list: "hi", "there"]) is [list: 2, 5]
  my-string-lens-map([list: "hi", "there"]) is [list: 2, 5]
  my-alternating([list: 10, 20, 30, 40, 50]) is [list: 10, 30, 50]
end