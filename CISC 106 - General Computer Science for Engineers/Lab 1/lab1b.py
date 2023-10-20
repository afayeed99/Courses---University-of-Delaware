# This file will be used to write your code
from customIO import *

# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Li Pei Soh
# Partner UDID: 702484287
# Lab 1 - Part B

# ----------------------------------------------
# Problem 16 - Assigning 3 values from keyboard
age = input("Enter your age:")
height = input("Enter your height in feet:")
name = input("Enter your first name:")
print(name, height, age)
print(age, height, name)

# ----------------------------------------------
# Problem 17 - Cats and Dogs problem
cats = input("Enter the number of cats registered in a course:")
cats = int(cats)
dogs = input("Enter the number of dogs registered in a course:")
dogs = int(dogs)
total_animals = cats + dogs
percentage_of_cats = float(100 * (cats / total_animals))
percentage_of_dogs = float(100 * (dogs / total_animals))
print(percentage_of_cats, percentage_of_dogs)

# ----------------------------------------------
# Problem 18 - Total Profit problem
total_sales = float(input("Enter the projected amount of total sales:"))
total_profit = total_sales * 0.51
print("Total Profit:", total_profit)

# ----------------------------------------------
# Problem 19 - Celcius Convertion problem
temperature_celcius = input("Enter the temperature in Celcius:")
temperature_celcius = float(temperature_celcius)
temperature_fahrenheit = (temperature_celcius * 9 / 5) + 32
print(temperature_fahrenheit)

# ----------------------------------------------
# Problem 20 - Books and Shiiping problem
number_of_books = input("Enter the number of books:")
number_of_books = int(number_of_books)
total_shipping_cost = 5 + (0.75 * (number_of_books - 1))
total_book_cost= 0.6 * 30.95 * number_of_books
total_cost = total_book_cost + total_shipping_cost
print("Total cost of books are", total_cost)
