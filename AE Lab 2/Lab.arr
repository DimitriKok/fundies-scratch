use context dcic2024
include csv
include data-source

# It is important to import both csv and data-source as it will let us load the csv file as a table. We must also make sure to use the context dcic 2024 as it gives us access to useful table functions

# Also make sure to include the penguins.csv file in the same directory as the .arr file

# To load the table, we must use load-table

penguins = load-table:
  index :: Number,
  species :: String,
  island :: String,
  bill_length_mm :: Number,
  bill_depth_mm :: Number,
  flipper_length_mm :: Number,
  body_mass_g :: Number,
  sex :: String,
  year :: Number
  source: csv-table-file("penguins.csv", default-options)
  sanitize index using num-sanitizer
  sanitize bill_length_mm using num-sanitizer
  sanitize bill_depth_mm using num-sanitizer
  sanitize flipper_length_mm using num-sanitizer
  sanitize body_mass_g using num-sanitizer
  sanitize year using num-sanitizer
end

# We import the following: index, species, island, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g, sex, and year. Make sure to include type anotation to ensure anyone looking at the code can clearly understand what each column contains. Also, sanitize the numbers so we can manipulate them later on

# It is also worth noting, the csv file did not have a name for the first column, it seemed as if it was just an index so i gave it the name index

# Now that we have the table loaded, we can finally start working on some problems

# According to lecture 6.2 Scalar Processing: Traverse structure and return a single value: sum, count

# Problem: Create a function where a user can specify a species and get an avergave value of one of the columns

# Example: Find the average bill length of all the Adelie species
# find-Average(penguins, Adelie, bill_length_mm)

# Thought Process
# Step 1: Filter the table based on the species specified
# Step 2: With the new filtered table, create a list of the column for the average
# Step 3: Calculate and return the average

fun find-Average(table :: Table, species :: String, col :: String) -> Number:
  doc: "Given a table, filter, and column, it will return the average of the specifed column"
  
  # Cretae a temporary table filtering by the species specified by the user
  temp-table = filter-with(table, lam(r :: Row): r["species"] == species end)
  
  # Save the column that the user wants the average to be taken of into a list
  avgList = temp-table.get-column(col)
  
  #Call the new list to a helper function that calculates the average
  calcAvg(avgList)
  
  # Create test cases to ensure the function works as intended
where:
  num-floor(find-Average(penguins, "Adelie", "bill_depth_mm")) is 18
  num-floor(find-Average(penguins, "Chinstrap", "body_mass_g")) is 3733
  num-floor(find-Average(penguins, "Gentoo", "flipper_length_mm")) is 217
end

fun calcAvg(l :: List) -> Number block:
  doc: "Helper function that calculates the average of a given list"
  
  # Make sure the function is a block so it has variables that can change in it
  
  # Create a total variable that adds all values of a lits using a for each loop
  var total = 0
  for each(n from l):
    total := total + n
  end
  
  # Return the total divided by the length of the list to find the average
  total / l.length()
end

find-Average(penguins, "Adelie", "bill_depth_mm")

# According to lecture 6.2 Transformation: Produce a new list

# Problem: Everything is in millimeters, make a new column converting a column of a users choice into inchs

# Example: Convert bill_length_mm into inches
# toInches(penguins, bill_length_mm)

# Thought Process
# Step 1: Create a new column name using string substrings to add in at the end of the name
# Step 1: Use the build-column function alongiside a lambda function for calculations
# Step 2: Return the new table 

fun toInches(t :: Table, c :: String) -> Table:
  doc: "Converts a column of a table from millimeters to inches"
  
  # Creates the new column name using string-substring and concatonating it with in
  newColName = string-substring(c, 0, string-length(c) - 2) + "in"
  
  # Creates the new column using build-column
  build-column(t, newColName, lam(n): num-to-string-digits(n[c] / 25.4, 2) end)
  
end

toInches(penguins, "bill_length_mm")

# According to lecture 6.2 Selection: Select particular elements based on value or position

# Problem: The user should be able to filter by any island, species, and either greater than or less than any one specific numberic column. Each filter should be togleable so they can use as many as they want

# Example: I want to find any Adelie on the island of torgersen with a bill length under 38
# penguinSearch(penguins, Adelie, Torgersen, 38, false)

# Example 2: I want to find any penguin on the island of Dream
# penguinSearch(penguins, "", "Dream", 0, false)

# Though Process
# Step One: Create a new variable that uses an if statement to check if an input is given. If an input is given, filter by the input, else contine
# Step Two: Repeat this process for the island input
# Step Three: Check if a number to compare is given. If so, check if the user want it to be greater or less than. From there filter
# Step Four: Return the final table

fun penguinSearch(t :: Table, species :: String, island :: String, colToCompare :: String, num :: Number, greatLess :: Boolean) -> Table block:
  doc: "Filters a table with specific inputs given my the user. Leave any string null to ignore the field and leave the num field as 0 if there is no filter on numbers"

  # Variable that uses if statements. If a species is provided it will return a filter table of only that species
  caseOne = 
    if string-length(species) == 0:
      t
    else:
      filter-with(t, lam(r :: Row): r["species"] == species end)
    end
  
  # Variable that uses if statements. If an island is provided it will return a filter table of only that species
  caseTwo = 
    if string-length(island) == 0:
      caseOne
    else:
      filter-with(caseOne, lam(r :: Row): r["island"] == island end)
    end
  
  # Variable that uses if statements. If a number to compare is provided it will return a filtered table. If greatLess is true, it will return values greater than the number, false: less. 
  caseThree =
    if num == 0:
      caseTwo
    else:
      if greatLess == true:
        filter-with(caseTwo, lam(r :: Row): r[colToCompare] >= num end)
      else:
        filter-with(caseTwo, lam(r :: Row): r[colToCompare] <= num end)
      end
    end
  
  caseThree
end

# All Chinstrap penguins with a bill length greater or equal to then 39
penguinSearch(penguins, "Chinstrap", "", "bill_length_mm", 39, true)

# All Gentoo penguins on the island of Biscoe
penguinSearch(penguins, "Gentoo", "Biscoe", "", 0, false)

# All penguins with a flipper length under or equal to 200
penguinSearch(penguins, "", "", "flipper_length_mm", 172, false)


# According to lecture 6.2 Accumulation: Pass additional data within the list processing function

# Problem: Create a function that creates a unique identifier for each penguin

# Example: ADEN1837M7
# addUID(penguins)

# Thought Process
# Step 1: Use build colomun alongside the following methods: String to upper, string substring, string length, string to num

fun addUID(t :: Table) -> Table:
  doc: "Adds a unique identifyier to all penguins"
  
  # I am aware that doing it all in one line is not good practice but i was unsure of how to do it otherwise
  final = build-column(t, "UID", lam(r:: Row): string-to-upper(string-substring(r["species"], 0, 2)) +  string-to-upper(string-substring(r["island"], (string-length(r["island"]) - 2), string-length(r["island"]))) + string-substring(num-to-string(r["flipper_length_mm"]), 0, 2) + string-substring(num-to-string(r["body_mass_g"]), 0, 2) + string-substring(string-to-upper(r["sex"]), 0, 1) + string-substring(num-to-string(r["year"]), string-length(num-to-string(r["year"])) - 1, string-length(num-to-string(r["year"]))) end)
  
  final
  
end

addUID(penguins)
