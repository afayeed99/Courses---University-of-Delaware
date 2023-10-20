# This file will be used to write your code
from variables import *
from customIO import *

# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L 
# Partner Name: Li Pei Soh
# Partner UDID: 702484287
# Lab 1 - Simple Python Data - Part A

# ----------------------------------------------
# Problem 1 - Display 4 equal signs
print("====")

# ----------------------------------------------
# Problem 2 - Display an empty string
print("")

# ----------------------------------------------
# Problem 3 - Display the address of Smith Hall and UD's phone number
smith_hall_address = "18 Amstel Ave, Newark, DE 19716"
ud_phone_number = "(302) 831-2792"
print(smith_hall_address)
print(ud_phone_number)

# ----------------------------------------------
# Problem 4 - Define a variable (not sure the difference of define and assign)
sqrt2 = 1.41421

# ----------------------------------------------
# Problem 5 - Assign an integer
five = 5

# ----------------------------------------------
# Problem 6 - Assign a float
boiling = 212.0

# ----------------------------------------------
# Problem 7 - Assign a string
suit = "spades"

# ----------------------------------------------
# Problem 8 - Assign two float values
height = 84.5
weight = 188.0

# ----------------------------------------------
# Problem 9 - Freshman - Graduate problem
frosh_age = int(input("Enter your age as a freshman:"))
grad_age = frosh_age + 4
print("Your age when you graduated is", grad_age)

# ----------------------------------------------
# Problem 10 - Meal Cost problem
foodCost = float(input("Enter the cost of food:"))
drinkCost = float(input("Enter the cost of drink:"))
mealCost = foodCost + drinkCost
print("The total cost of meal is", mealCost)

# ----------------------------------------------
# Problem 11 - Concert Ticket problem 
numTickets = int(input("Enter the number of tickets sold to a concert:"))
price = float(input("Enter the cost of each ticket:"))
totalCost = numTickets * price
print("The total value of tickets sold are", totalCost)

# ----------------------------------------------
# Problem 12 - Time problem
startTime = int(input("Enter the start time:"))
endTime = int(input("Enter the end time:"))
elapsedTime = endTime - startTime
print("The total time taken is", elapsedTime)

# ----------------------------------------------
# Problem 13 - Flooring problem
length1 = float(input("Length of rectangle 1:"))
width1 = float(input("Width of rectangle 1:"))
length2 = float(input("Length of rectangle 2:"))
width2 = float(input("Width of rectangle 2:"))
totalArea = length1 * width1 + length2 * width2
print("Total area of two rectangular pieces of flooring are", totalArea)

# ----------------------------------------------
# Problem 14 - Class problem
firstInClass, secondInClass = secondInClass, firstInClass
print("The first person's name in class is", firstInClass)
print("The second person's name in class is", secondInClass)

# ----------------------------------------------
# Problem 15 - Average Data problem
data_1 = 8.5
data_2 = 2.3
data_3 = 3.4
avg_data = (data_1 + data_2 + data_3) / 3
print("The average data is", avg_data)