use context starter2024

# #create a green triangle
# green_triangle = triangle(35, 'solid', 'green')

# #display the triangle
# #green_triangle

# num_a = 10
# num_b = 16

# #take sum of both numbers
# total = num_a + num_b

# #display the total
# #total

# #take the product
# product_a_b = num_a * num_b

# #display product of a and b
# product_a_b


#Class Exercise

#defines an orange triangle

triangleLength = 35
triangleColor = "orange"
orange-triangle = triangle(triangleLength, 'solid', triangleColor)

#evaluates the triangle
orange-triangle

#variables for side and color of square
sideLength = 30
color = "blue"

#create the square
blueSquare = square(sideLength, 'solid', color)

blueSquare

#create the square without the variables
blueSquareNoVars = square(30, "solid", "blue")

blueSquareNoVars

#change the value of side length then print it
# sideLength = 10
# blueSquare
#This causes an error as it is shadowning


#creating a yellow circle on top of a black circle. This is the easiest way to read

#defines a radius
radius = 10

#uses the radius to create the shape
yellowCircle = circle(radius, "solid", "yellow")

rectLength = 70
rectHeight = 30

blackRectangle = rectangle(rectLength, rectHeight, "solid", "black")

above(yellowCircle, blackRectangle)


#alt harder version to read
# above(circle(10, "solid", "yellow"),
#   rectangle(70, 30, "solid", "black"))

#creates a defintion for two circles side by side
twoCircles = beside(yellowCircle, yellowCircle)

#prints two circles on top of a rectangle
above(twoCircles, blackRectangle)


#Alt way, harder to read
# above(beside(yellowCircle, yellowCircle),
#   blackRectangle)