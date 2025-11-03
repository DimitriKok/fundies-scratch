use context dcic2024
include csv
include data-source
include lists

# Loads the table
student_score = load-table:
  Name :: String,
  Surname :: String,
  Email :: String,
  Score :: Number
  source: csv-table-file("students_gate_exam_score.csv", default-options)
  sanitize Score using num-sanitizer
end


# Getting the top 3 students based on their scores. Uses order-by to sort the table by highest score
get-row(order-by(student_score, "Score", false), 0)

get-row(order-by(student_score, "Score", false), 1)

get-row(order-by(student_score, "Score", false), 2)

# Creates the student data type
data Student:
    student(name :: String, surname :: String, Score :: Number)
end
    
# Creating variable for the top 3 students, assigning each to the student data type
s1 = student("Ethan", "Gray", 97)

s2 = student("Oscar", "Young", 92)

s3 = student("Adrian", "Benett", 80)

# Creates a list of scores
scores :: List<Number> = link(s1.Score, link(s2.Score, link(s3.Score, empty)))

# Creates a funciton that add all scores greater than 90
fun greaterThanNinty(l :: List<Number>) block:
  cases(List) l:
    | empty => 0
    | link(f, r) => (if f > 90 : 1 else: 0 end) + greaterThanNinty(r)
   end
end

greaterThanNinty(scores)

# Creates a List of student objects
top3 :: List<Student> = link(s1, link(s2, link(s3, empty)))

# Funciton that checks if the score is greater than 80
fun greaterThanEighty(l :: List<Number>) block:
  cases(List) l:
    | empty => empty
    | link(f, r) => (if f.Score > 80: link(f, greaterThanEighty(r)) else: greaterThanEighty(r) end)
   end
end

greaterThanEighty(top3)

# Is there a better way to get the emails from the table into a list
# For each loop maybe?
all-emails = [list: "a.bennett@northeastern.edu", "b.clark@virginia.edu", "c.evans@alabama.edu", "d.foster@virginia.edu", "e.gray@nulondon.ac.uk", "f.hughes@northeastern.edu", "g.king@northeastern.edu", "h.lewis@nulondon.ac.uk", "i.morgan@california.edu", "j.parker@virginia.edu", "k.reed@virginia.edu", "l.scott@alabama.edu", "m.turner@nulondon.ac.uk", "n.walker@california.edu", "o.young@nulondon.ac.uk"]

fun get-domain(l :: String):
  a = string-split(l, "@")
  b = a.get(1)
  c = string-split(b, ".")
  c.get(0)
end

distinct(all-emails.map(get-domain))

fun replace-domain(s :: String):
  a = string-split(s, "@")
  b = a.get(1)
  if string-contains(b, "uk"):
    "northeastern.edu"
  else:
    b
  end
end

all-emails.map(replace-domain)