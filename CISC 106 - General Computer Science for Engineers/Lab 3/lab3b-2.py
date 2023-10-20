# This is where you will write your code for Lab 3 Part B
# Do not delete these lines
from cisc106 import *
from customIO import *

# ---------------------------------------------------------
# Lab 3 - Part B#
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner's Name: Robert McCulley
# Partner's UDID: 702466861
# Lab 3 - Defining and Testing Functions Requiring Selection Statements
# ----------------------------------------------

# Problem 13 - Function that determines the numeric type
def sign(numeric):
    '''
    Returns the value of -1, 1, and 0 when the arguments given are negative, positive, and 0 respectively
    Parameters:
        numeric : (float) - any float number
    Returns:
        numeric_type : (int)
    '''
    if numeric < 0:
        numeric_type = -1
    elif numeric > 0:
        numeric_type = 1
    else:
        numeric_type = 0
    return numeric_type

assertEqual(sign(-4.3),-1)
assertEqual(sign(4.0),1)
assertEqual(sign(0),0)

# ----------------------------------------------
# Problem 14 - Function that determines the boolean type of the equation
def less_than_five(n):
    '''
    Determines whether the numeric n is less than 5 or not
    Parameter:
        n : (float) - numeric is less than 5
    Return:
        truth : (bool)
    '''
    truth = n < 5
    return truth
    
assertEqual(less_than_five(4.1),True)
assertEqual(less_than_five(5.0),False)
assertEqual(less_than_five(6.5),False)

# ----------------------------------------------
# Problem 15 - Function that determines whether argument 1 is the multiple of argument 2 or not
def is_multiple(num1,num2):
    '''
    Determines whether the first argument is the multiples of the second argument
    Parameters:
        num1 : (float) - any float number
        num2 : (float) - any float number
    Returns:
        truth : (bool)
    '''
    truth = num1 % num2 == 0
    return truth
    
assertEqual(is_multiple(8,4),True)
assertEqual(is_multiple(6,5),False)
assertEqual(is_multiple(7,3),False)

# ----------------------------------------------
# Problem 16 - Function that determines the bmi risk
def bmi_risk(bmi,age):
    '''
    Determines the bmi risk given the bmi and the age of the person
    Parameter:
        bmi : (float) - the body mass index
        age : (int) - the age of the person 
    Return:
        risk : (str) - the bmi is either low, medium or high
    '''
    if bmi < 22 and age < 45:
        risk = "Low"
    elif bmi < 22 or bmi >= 22 and age < 45:
        risk = "Medium"
    elif bmi >= 22 and age >= 45:
        risk = "High"
    return risk

assertEqual(bmi_risk(20.4,43),"Low")
assertEqual(bmi_risk(21.0,50),"Medium")
assertEqual(bmi_risk(30.9,45),"High")

# ----------------------------------------------
# Problem 17 - Function that returns the number of cards in black jack game
def black_jack(a,b):
    '''
    Returns the value that is the nearest to 21 without going over it
    Parameter:
        a : (int) - an integer a that is 0 <= a <= 21
        b : (int) - an integer b that is 0 <= b <= 21
    Return:
        expectation : (int) - a, b, or 0
    '''
    if a > 0 and a <= 21 and b > 0 and b <= 21:
        expectation = max(a,b)
    elif (a > 21 or a <= 0) and b > 0 and b <= 21:
        expectation = b
    elif a > 0 and a <= 21 and (b > 21 or b <= 0):
        expectation = a
    elif (a > 21 or a <= 0) and (b > 21 or b <= 0):
        expectation = 0
    return expectation

assertEqual(black_jack(21,21),21)
assertEqual(black_jack(18,18),18)
assertEqual(black_jack(19,18),19)
assertEqual(black_jack(22,3),3)
assertEqual(black_jack(13,23),13)
assertEqual(black_jack(22,-5),0)
assertEqual(black_jack(-14,23),0)

# ----------------------------------------------
# Problem 18 - Function that determines the exam grade
def course_grade(score):
    '''
    Returns the letter grade given the exam score
    Parameter:
        score : (int) - score receives from the exam
    Return:
        grade : (str) - letter grade for exam
    '''
    if score <= 10:
        grade = "F"
    elif 11 <= score <= 20:
        grade = "D"
    elif 21 <= score <= 30:
        grade = "C"
    elif 31 <= score <= 50:
        grade = "B"
    elif score > 50:
        grade = "A"
    return grade
    
def main():
    '''
    Prompts the user for their exam score and return their grades
    Parameter:
        None
    Return:
        final_grade : (str) - exam's grade
    '''
    exam_score = int(input("Enter your exam score: "))
    final_grade = course_grade(exam_score)
    return final_grade

assertEqual(course_grade(15),"D")
assertEqual(course_grade(25),"C")
assertEqual(course_grade(47),"B")

# ----------------------------------------------
# Problem 19 - Function that calculates the number of points received by the customers
def calculate_points(number_of_books):
    '''
    Calculates the total points received given the number of books purchased
    Parameter:
        number_of_books : (int) - number of books purchased by customer
    Return:
        points : (int) - number of points the customer received
    '''
    if number_of_books == 0 or number_of_books == 1:
        points = 0
    elif number_of_books == 2 or number_of_books == 3:
        points = 5
    elif number_of_books >=4 and number_of_books <= 7:
        points = 15
    elif number_of_books >= 8:
        points = number_of_books * 60
    return points
    
assertEqual(calculate_points(1),0)
assertEqual(calculate_points(6),15)
assertEqual(calculate_points(8),480)
    
# ----------------------------------------------
# Problem 20 - Function that compute the commission earned by a salesperson
def compute_commission(model,number_of_features):
    '''
    Computes commission of the salesperson given car model and number of features sold
    Parameter:
        model : (str) - "basic", "mid" or "luxury"
        number_of_features : (int) - number of features sold by the salesperson
    Return:
        commission : (int) - total money earned by salesperson
    '''
    if model == "basic":
        commission = 1000 + (number_of_features * 100)
    elif model == "mid":
        commission = 1500 + (number_of_features * 100)
    elif model == "luxury":
        commission = 2000 + (number_of_features * 100)
    return commission

assertEqual(compute_commission("basic",5),1500)
assertEqual(compute_commission("mid",3),1800)
assertEqual(compute_commission("luxury",2),2200)
    
# ----------------------------------------------
# Problem 21 - Function that determines the day of the week after a number of days passed since the Blip Blob New Year
def blip_blop_day(number_of_days):
    '''
    Determines the day of the week given the number of days passed
    Parameter:
        number of days : (int) - number of days passed since the celebration
    Return:
        day : (str) - day of the week
    '''
    if number_of_days % 7 == 0:
        day = "Tuesday"
    elif number_of_days % 7 == 1:
        day = "Wednesday"
    elif number_of_days % 7 == 2:
        day = "Thursday"
    elif number_of_days % 7 == 3:
        day = "Friday"
    elif number_of_days % 7 == 4:
        day = "Saturday"
    elif number_of_days % 7 == 5:
        day = "Sunday"
    elif number_of_days % 7 == 6:
        day = "Monday"
    return day

assertEqual(blip_blop_day(5),"Sunday")
assertEqual(blip_blop_day(8),"Wednesday")
assertEqual(blip_blop_day(9),"Thursday")

# ----------------------------------------------
# Problem 22 - Function that computes the mathematical functions
def f(x):
    return x ** 2 - 3

def g(x,y):
    return x - f(f(y))

def h(x,y,z):
    return g(x,y) + z
    
assertEqual(f(3),6)
assertEqual(g(1,2),3)
assertEqual(h(2,3,4),-27)

# ----------------------------------------------
# Problem 23 A - Function that calculate the total charge for the internet service
def bill_small(amount_of_data,base_value):
    '''
    Calculates the total bill given the amount of data and base value
    Parameter:
        amount_of_data : (int) - number of gigabytes
        base_value : (int) - cost for internet service
    Return:
        charge : (float) - total cost
    '''
    charge = round((base_value),2)
    return charge
    
def bill_medium(amount_of_data,base_value):
    '''
    Calculates the total bill given the amount of data and base value
    Parameter:
        amount_of_data : (int) - number of gigabytes
        base_value : (int) - cost for internet service
    Return:
        charge : (float) - total cost
    '''
    charge = round(((0.15 * base_value) + base_value + 0.07 * (amount_of_data - 100)),2)
    return charge

def bill_large(amount_of_data,base_value):
    '''
    Calculates the total bill given the amount of data and base value
    Parameter:
        amount_of_data : (int) - number of gigabytes
        base_value : (int) - cost for internet service
    Return:
        charge : (float) - total cost
    '''
    charge = round((2 * base_value),2)
    return charge
    
assertEqual(bill_small(50,80),80.0)
assertEqual(bill_small(50,90),90.0)
assertEqual(bill_medium(200,80),99.0)
assertEqual(bill_medium(200,100),122.0)
assertEqual(bill_large(1000,80),160.0)
assertEqual(bill_large(2000,90),180.0)

# ----------------------------------------------
# Problem 23 B - Function that calculate the total bill of the internet service   
def total_bill(amount_transferred, base_rate):
    '''
    Calculates the total bill given the amount of data and base value
    Parameter:
        amount_transferred : (int) - number of gigabytes
        base_rate : (int) - cost for internet service
    Return:
        charges : (float) - total bill
    '''
    if amount_transferred <= 100:
        charges = bill_small(amount_transferred, base_rate)
    elif amount_transferred > 100 and amount_transferred <= 1000:
        charges = bill_medium(amount_transferred, base_rate)
    elif amount_transferred > 1000:
        charges = bill_large(amount_transferred, base_rate)
    return charges
    
assertEqual(total_bill(30,80),80.00)
assertEqual(total_bill(150,80),95.50)
assertEqual(total_bill(3000,80),160.00)