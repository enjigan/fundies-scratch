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