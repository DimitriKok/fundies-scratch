use context dcic2024
include csv
include data-source

#Problem 1
fun isLeapYear(year :: Number) -> Boolean:
  doc: "Takes an int paramter 'year' and checks if it is a leap year (if it is divisible by 4)"
  if (num-modulo(year, 4) == 0):
    true
  else:
    false
  end
  
#Checking that it works
where:
  isLeapYear(2024) is true
  isLeapYear(2025) is false
end



#Problem 2
fun tick(second :: Number) -> Number:
  doc: "Takes an int pramater, gives the next second in a minute, returns -1 if second is greater than 59"
  ask:
    | (second >= 0) and (second < 59) then: second + 1
    | second == 59 then: 0
    | (second < 0) or (second > 59) then: -1
  end
  
  #Checking that it works in all cases
where:
  tick(12) is 13
  tick(59) is 0
  tick(159) is -1
end



#Problem 3
fun rock-paper-scissors(inputOne :: String, inputTwo :: String) -> String:
  doc: "Takes two string inputs for a rock paper scissors game. The inputs can be Rock Paper or Scissors. Then returns the winner or returns an error if an invalid option is given"
  
  #makes all text lowercase to avoid errors
  one = string-to-lower(inputOne)  
  two = string-to-lower(inputTwo)
  
  #logic for game, likely not the most efficient way to make it
  ask:
    | (one == "rock") and (two == "rock") then: "tie"
    | (one == "rock") and (two == "paper") then: "player 2 wins"
    | (one == "rock") and (two == "scissors") then: "player 1 wins"
    | (one == "paper") and (two == "rock") then: "player 1 wins"
    | (one == "paper") and (two == "paper") then: "tie"
    | (one == "paper") and (two == "scissors") then: "player 2 wins"
    | (one == "scissors") and (two == "rock") then: "player 2 wins"
    | (one == "scissors") and (two == "paper") then: "player 1 wins"
    | (one == "scissors") and (two == "scissors") then: "tie"
    | otherwise: "error in input"
  end

  #checking that the function works
where:
   rock-paper-scissors("asdf", "paper") is "error in input"
  rock-paper-scissors("rock", "paper") is "player 2 wins"
end



#Problem 4
#Creating a table with planet data in it
planets = table: planet :: String, distance :: Number
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end

#Extracting row 3 to a variable named mars
mars = planets.row-n(3)

#Extracting the distance from the mars variable
mars["distance"]



#Problem 5
#Loads the table with 5 columns, then sanitizes them
something = load-table:
  year :: Number,
  day :: Number,
  month :: String,
  rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize year using num-sanitizer
  sanitize day using num-sanitizer
  sanitize rate using num-sanitizer
end

#Returns number of rows in the table
something.length()

#Finds the median rate of the table
median(something, "rate")

#Finds the mode of the rates
modes(something, "rate")

#Sort by ascending rates
order-by(something, "rate", true)

#Sort by descending rates
order-by(something, "rate", false)