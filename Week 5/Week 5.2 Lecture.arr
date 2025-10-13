use context starter2024
include math
include statistics


cafe-data =
  table: day, drinks-sold
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed", 55
    row: "Thu", 40
    row: "Fri", 60
  end

cafe-list = cafe-data.get-column("drinks-sold")

sample-list = [list: 4,5,6,7,8]
sample-list

empty-list = [list:]

max(cafe-list)
min(cafe-list)
mean(cafe-list)
sum(cafe-list)


discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]

upper-discodes = map(string-to-upper, discount-codes)

distinct-discodes = distinct(upper-discodes)

distinct-discodes



codes = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]


upper-codes = map(string-to-upper, codes)

distinct-codes = distinct(upper-codes)

distinct-codes

filter(lam(n :: String): not(n == "MAYBE") end, distinct-codes)

fun compute-product(num-list :: List) -> Number block:
  var total = 1
  for each(n from num-list):
    total := total * n
  end
  total
end

listOne = [list: 1,2,3,4,5,6]

fun sum-even-numbers(nL :: List) -> Number block:
  var total = 0
  for each(n from nL):
    if (num-modulo(n, 2) == 0):
      total := total + n
    else:
      total := total + 0
    end
  end
  total
end

sum-even-numbers(listOne)

fun my-length(nL :: List) -> Number block:
  var total = 0
  for each(n from nL):
    total := total + 1
  end
  total
end

my-length(listOne)

fun my-doubles(nL :: List) -> List:
  map(lam(n): n * 2 end, nL)
end

my-doubles(listOne)

# fun my-string-lens(nL :: List) -> List block:
#   var newList = [list:]
#   var total = 0
#   for each(n from nL):
#     newList.push(total)
#   end
#     newList
# end



# fun my-alternating(lst :: List) -> List block:
#   doc: "returns every other element from a list"
#   var result = [list: ]
#   var index = 0
  
#   repeat while index < lst.length()
#   when num-modulo(index, 2) == 0:
#     result := result.append([list: lst.get(index)])
#   end
#   index := index + 1
# end

# my-alternating(listOne)