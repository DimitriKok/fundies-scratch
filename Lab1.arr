use context starter2024
include image

#T-shirt shop

#First expression to calculate the cost of 5 T-shirts
(12 * 5) - 3

#Second expression to calculate the cost of 7 T-shirts
(12 * 7) - 3

#Third expression to calculate the cost of a poster
(2 * (420 + 594)) * 0.10

#If you forget parentheses, pyret throws error messages


#String Surprises

#Prints the string, if one quotation is removed it spits an error stating 'pyret things this is a string'
"Designs for everyone!"

#adding 2 strings combines them into one consecutive sting
"red" + "blue" + "gold"

#Pyret throws an error if you try to add values of two differnt types
# ex. 1 + "blue"


#Make a Traffic Light

#Defining circles in a statment to make sure code is clean later on
greenCirc = circle(15, "solid", "green")

yellowCirc = circle(15, "solid", "yellow")

redCirc = circle(15, "solid", "red")

challPole = rectangle(10, 40, "solid", "black")

#Utilization of the overlay-align method to place shapes on top of each other

#above statement used to add pole under the traffic light

above(overlay-align("center", "bottom", redCirc,
  overlay-align("center", "center", yellowCirc,
  overlay-align("center", "top", greenCirc,
        rectangle(40, 100, "solid", "black")))),
  challPole)


#Broken Code Hunt

# # Goal: A rectangle with width 50 and height 20, solid black
# rectangle(50, "solid", 20, "black")

#The order of inputs is wrong, it should be 2 ints first then 2 strings
rectangle(50, 20, "solid", "black")


#circle(30, solid, "red")
#Missing "" around solid

circle(30, "solid", "red")


#Create a Flag or Shield: Itallian Flag

greenStripe = rectangle(20, 40, "solid", "green")

whiteStripe = rectangle(20, 40, "solid", "white")

redStripe = rectangle(20, 40, "solid", "red")

beside(greenStripe,
  beside(whiteStripe, redStripe))

#Shield Design
diamond = rotate(45, square(60, "solid", "blue"))

#declaring a rectangle to form into a cross
rect = (rectangle(5, 60, "solid", "grey"))

#creating a cross shape in a variable
cross = overlay-align("center", "center", rect, rotate(90, rect))

#Printing the shiteld all together
overlay-align("center", "center", cross, diamond)