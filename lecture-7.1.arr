use context starter2024
include lists

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