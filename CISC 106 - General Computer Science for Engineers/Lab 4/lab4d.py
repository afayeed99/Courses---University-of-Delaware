# This is where you will write your code for Lab 4 Part D
# Do not delete these lines
from cisc106 import *
from customIO import *

# ---------------------------------------------------------
# Lab 4 - Part D
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Lab 4 - Debugging Functions 
# ----------------------------------------------

# Problem 19 - Debugging the course average function

def course_average(grade1, grade2, grade3):
    crse_avg = (grade1 + grade2 + grade3) / 3
    return crse_avg
   
def main():
    print('Welcome to Course Average Tool.')
    
    message1 = 'Enter first number: '
    grade_1 = float(input(message1))
    
    message2 = 'Enter second number: '
    grade_2 = float(input(message2))
    
    message3 = 'Enter third number: '
    grade_3 = float(input(message3))
    
    average_number = course_average(grade_1, grade_2, grade_3)
    print('The average of',grade_1, ',', grade_2, 'and', grade_3, 'is', average_number)
    