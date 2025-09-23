use context starter2024
# fun addTwoNumbers(numOne, numTwo):
#   #computation
#   numOne + numTwo
# end

# addTwoNumbers(10, 5)

# addTwoNumbers(2, 5)

# fun welcome(name):
#   #prints concatonated text
#   "Welcome to class, " + name
# end

# welcome("John")
# welcome("Danny")
# welcome("Sean")

# fun area(width, height):
#   doc: "multiplies the with and height defined by later use. 2 Parameters, both ints"
#   width * height
# end


# check:
#   area(10, 25) is 10 * 25
#   area(1, 5) is 1 * 5
# end

# fun welcome(name :: String) -> String:
#   doc: "Welcome: string -> string; Purpose: to display a greetings message"
#   "Welcome to class, " + name
# end

# welcome("Stu")


fun costOfT(amt, message):
  doc: "costOfT: int :: string -> int; Purpose: Calculates the cost of a T-shirt"
  (5 * amt) + (string-length(message) * 0.1)
end

costOfT(4, "Go Team!")

costOfT(7, "Hello World")


fun celcius-to-fahrenheit(celcius :: exactNum):
  doc: "fahrenheit-to-celcius: int -> int; Purpose: user inputs c and converts it to f"
  ((celcius * 9) / 5) + 32
end


celcius-to-fahrenheit(12)

fun fahrenheit-to-celcius(f):
  doc: "fahrenheit-to-celcius: int -> int; Purpose: user inputs f and converts it to c"
  ((f - 32) * 5) / 9
end

fahrenheit-to-celcius(53.6)


fun greekFlag(colOne :: String, colTwo :: String):
  doc: "greekFlag: string :: string -> img; Purpose: creates a greek flag witht the colors of the users choice"
  #Greek Flag

  #defines white and blue stripes
  shortBlueStripe = rectangle(80, 10, "solid", colOne)

  shortWhiteStripe = rectangle(80, 10, "solid", colTwo)

  longBlueStripe = rectangle(120, 10, "solid", colOne)

  longWhiteStripe = rectangle(120, 10, "solid", colTwo)

  #creates white stripes for the cross
  crossStripe = rectangle(5, 40, "solid", colTwo)

  #puts the cross together
  cross = overlay(overlay(crossStripe, rotate(90, crossStripe)),
    square(40, "solid", colOne))


  #stacks short stripes
  shortStack = above(shortBlueStripe, shortWhiteStripe)

  fullShort = above(shortStack, shortStack)

  #Add the cross
  topHalf = beside(cross, fullShort)

  #stacks long stripes
  longStack = above(longBlueStripe, longWhiteStripe)

  fullLong = above(longStack, longStack)

  #full flag
  above(topHalf, fullLong)
end

greekFlag("Green", "Orange")




