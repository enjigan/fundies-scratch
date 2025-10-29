use context dcic2024
include lists

# Selection: Creates a new list with only elements with more than 5 characters
fun more-than-five(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if string-length(f) > 5:
        link(f, more-than-five(r))
      else:
        more-than-five(r)
      end
  end
end

check:
  more-than-five([list: "Ethan", "Isabella", "Mia", "William"])
    is [list: "Isabella", "William"]

  more-than-five([list: "Anna", "Charlotte", "Ben"])
    is [list: "Charlotte"]

  more-than-five([list: "Noah", "Liam"])
    is [list:]
  end

# Relaxed Domains: Combines my-len and my-sum functions 
fun my-len(l):
  cases (List) l:
    | empty      => 0
    | link(f, r) => 1 + my-len(r)
  end
where:
  my-len([list: 7, 8, 9]) is 3
end

fun my-sum(l):
  cases (List) l:
    | empty      => 0
    | link(f, r) => f + my-sum(r)
  end
where:
  my-sum([list: 7, 8, 9]) is 24
end

fun my-average(l):
  if my-len(l) == 0:
    raise("Cannot take average of an empty list")
  else:
    my-sum(l) / my-len(l)
  end
end

check:
  my-average([list: 1, 2, 3, 4]) is 10 / 4
  my-average([list: 3, 4]) is 7 / 2
  my-average([list: 4]) is 4 / 1
  my-average([list: ]) raises "Cannot take average of an empty list"
end

# Define a my-max function using an accumulator
fun my-max1(l):
  m-m1(0, l)
where:
  my-max1([list: 5, 10, 6]) is 10
end

fun m-m1(biggest-number-encountered, l):
  cases (List) l:
    | empty => biggest-number-encountered
    | link(f, r) =>
      if f > biggest-number-encountered:
        m-m1(f, r)
      else:
        m-m1(biggest-number-encountered, r)
      end
  end
end


# Define a my-alternating function using an accumulator
fun my-alternating1(l):
  my-alt1(true, l)
where:
  my-alternating1([list: 1, 2, 3, 4, 5]) is [list: 1, 3, 5]
  my-alternating1([list: "a", "b", "c", "d"]) is [list: "a", "c"]
end

fun my-alt1(keep, l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      ask:
        | keep then: link(f, my-alt1(false, r))
        | otherwise: my-alt1(true, r)
      end
  end
end