use context starter2024
fun my-len(l :: List<Any>) -> Number:
  cases (List) l:
    | empty      => 0
    | link(f, r) => 1 + my-len(r)
  end
end

check:
  my-len([list: 7, 8, 9]) is 3
  my-len([list: ]) is 0
end
fun my-sum(l :: List<Number>) -> Number:
  cases (List) l:
    | empty      => 0
    | link(f, r) => f + my-sum(r)
  end
end

check:
  my-sum([list: 7, 8, 9]) is 24
  my-sum([list: ]) is 0
end
fun my-double(l :: List<Number>) -> List<Number>:
  cases (List) l:
    | empty      => empty
    | link(f, r) => link(f * 2, my-double(r))
  end
end

check:
  my-double([list: 3, 5, 2]) is [list: 6, 10, 4]
  my-double([list: ]) is [list: ]
end
fun positives(l :: List<Number>) -> List<Number>:
  cases (List) l:
    | empty      => empty
    | link(f, r) =>
        if f > 0:
          link(f, positives(r))
        else:
          positives(r)
        end
  end
end

check:
  positives([list: -2, 0, 3, -1, 5]) is [list: 3, 5]
end
# Helper that carries the partial result (acc)
fun string-concat-acc(l :: List<String>, acc :: String) -> String:
  cases (List) l:
    | empty      => acc
    | link(f, r) => string-concat-acc(r, string-append(acc, f))
  end
end

# Public function
fun string-concat(l :: List<String>) -> String:
  string-concat-acc(l, "")
end

check:
  string-concat([list: "cs", "20", "00"]) is "cs2000"
  string-concat([list: ]) is ""
end

