use context starter2024

dummy-list = [list: 1,2,3,4]

dummy-list

dummy-list.first

dummy-list.rest

dummy-list-1 = dummy-list.rest
dummy-list-2 = dummy-list-1.rest
dummy-list-3 = dummy-list-2.first

dummy-list-3

check:
  [list:        ] is empty
  [list: 1      ] is link(1, empty)
  [list: 1, 2   ] is link(1, link(2, empty))
  [list: 1, 2, 3] is link(1, link(2, link(3, empty)))
end

[list: 7, 8, 9, 10, 11, 12].length()

fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
where:
  my-len([list: 7,8,9]) is 3
  my-len([list: 7,8]) is 2
  my-len([list: 7]) is 1
  my-len([list:]) is 0
  
  my-len([list: 55,56,57,58]) is 1 + my-len([list: 56,57,58])
end


newList = [list: 3,7,2,9,1]

fun findMax(l :: List) -> Number block:
  cases (List) l:
    | empty => -999999
    | link(f,r) => num-max(f, findMax(r))
  end
where:
  findMax([list: 4,5,6,7]) is 7
  findMax([list: 0]) is 0
  findMax([list: ]) is -999999
end

fun string-upper(l :: List) -> String block:
  cases (List) l:
    | empty => ""
    | link(f,r) => string-toupper(f) + string-upper(r)
  end
end

string-upper([list: "a", "b"])

fun string-concat(l :: List) block:
  cases (List) l:
    | empty => ""
    | link(f,r) => f + string-concat(r)
  end
end

string-concat([list: "a", "b", " ahh"])


fun round-numbers(l :: List<Number>) -> List<Number>:
  cases(List) l:
    | empty => empty
    | link(f, r) => link(num-round(f), round-numbers(r))
  end
end

round-numbers([list: 1.2, 5.2])