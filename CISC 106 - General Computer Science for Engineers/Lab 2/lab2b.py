# This is where you will write your code for Lab 2 Part B
# Do not delete these lines
from cisc106 import *
from customIO import *

# ---------------------------------------------------------
# Lab 2 - Part B
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Lab 2 - Defining and Testing Functions - Part B
# ----------------------------------------------

# Problem 11 - Defining function that calculate the grades
def calculate_grade(lab_score, test_score):
    '''
    Computes grade
    Parameters:
        lab_score: (float) - sum of student's lab scores
        test_score: (float) - sum of student's test scores
    Returns:
        grade: (float) - student's course grade
    '''
    # grade is the student's calculated course grade
    grade = (lab_score + test_score) / 290
    return grade

assertEqual(round(calculate_grade(90.1, 180.5),2), 0.93)
assertEqual(round(calculate_grade(78.5, 170.9),2), 0.86)
assertEqual(round(calculate_grade(88.5, 193.2),2), 0.97)

# ----------------------------------------------
# Problem 12 - Executing the grade calculation function
lab = float(input("Enter lab score:"))
test = float(input("Enter test score:"))
print("Course grade is", round(calculate_grade(lab, test), 2))

# ----------------------------------------------
# Problem 13 - Defining function that greets a given argument
def greeting(name):
    print("Hello,", name)
    return

greeting("cat")

# ----------------------------------------------
# Problem 14 - Defining a function that converts miles to kilometers
def miles_to_kilometers(number):
    distance_in_miles = number * 1.6
    return distance_in_miles
    
assertEqual(miles_to_kilometers(10),16.0)
assertEqual(miles_to_kilometers(15),24.0)
assertEqual(miles_to_kilometers(35),56.0)

print(miles_to_kilometers(1.0))

# ----------------------------------------------
# Problem 15 - Defining a function that multiplies two given arguments
def multiply(x,y):
    z = x * y
    return z
    
assertEqual(multiply(3,2),6)
assertEqual(multiply(10,-1),-10)
assertEqual(multiply(0.5,4.5),2.25)

print(multiply(3,2))
print(multiply(0.5,4.5))

# ----------------------------------------------
# Problem 16 - Defining a function that calculates the area of triangle
def calculate_triangle_area(height, base):
    '''
    Computes the area of a triangle given its height and base lengths
    Parameters:
        height: (float) - length of the triangle's height  
        base: (float) - length of the triangle's base
    Returns:
        area of the triangle:  (float)
    '''
    area = (1/2) * height * base
    return area

assertEqual(round(calculate_triangle_area(2.0, 2.0),2),2.0)
assertEqual(round(calculate_triangle_area(8.6, 3.0),2),12.9)
assertEqual(round(calculate_triangle_area(9.0, 5.3),2),23.85)

# ----------------------------------------------
# Problem 17 - Defining a function that calculates the pulses per minute of a patient
def pulse_rate(time_taken, number_of_pulse):
    '''
    Calculates the pulse rate given the time in seconds and the number of pulses
    Parameters:
        time_taken: (int) - number of seconds the nurse has counted pulses
        number_of_pulse: (int) - number of pulses the nurse counted
    Returns:
        pulse per minute: (float) 
    '''
    time_in_minute = time_taken / 60
    pulse_per_minute = number_of_pulse / time_in_minute
    return pulse_per_minute
    
assertEqual(round(pulse_rate(30, 22),1),44.0)
assertEqual(round(pulse_rate(50, 25),1),30.0)
assertEqual(round(pulse_rate(45, 30),1),40.0)

print(round(pulse_rate(30,22),1))

# ----------------------------------------------
# Problem 18 - Defining a function that determines the graduation year
def graduation_year(start_year):
    '''
    Calculates the expected on-time graduation year given the start year
    Parameters:
        start year: (int) - the year a student starts college
    Returns:
        expected on-time graduation year: (int)
    '''
    end_year = start_year + 4
    return end_year
    
assertEqual(graduation_year(2000), 2004)
assertEqual(graduation_year(2018), 2022)
assertEqual(graduation_year(2005), 2009)

print(graduation_year(2016))

# ----------------------------------------------
# Problem 19 - Defining a function that determines the matriculation year
def matriculation_year(end_year):
    '''
    Calculates the year the student must start the school given the graduation year
    Parameters:
        end year: (int) - the year the students graduate
    Returns:
        year student must starts school: (int)
    '''
    start_year = end_year - 4
    return start_year
    
assertEqual(matriculation_year(2000), 1996)
assertEqual(matriculation_year(2018), 2014)
assertEqual(matriculation_year(2005), 2001)

# ----------------------------------------------
# Problem 20 - Defining a function that squeeze the given arguments into one string
def make_string_sandwich(x,y):
    '''
    Writes the first argument followed by the second argument, second argument and first argument given two phrases
    Parameters:
        x: (str) - any phrase associated to it
        y: (str) - any phrase associated to it
    Returns:
        first argument followed by the second argument, second argument and first argument: (str)
    '''
    z = x + y + y + x
    return z
    
assertEqual(make_string_sandwich("ccc", "bb"), "cccbbbbccc")
assertEqual(make_string_sandwich("25","5r"), "255r5r25")
assertEqual(make_string_sandwich("Y",""), "YY")

# ----------------------------------------------
# Problem 21 - Defining a function that calculcates the manhattan distance of two points
def calculate_manhattan_distance(p1,p2,q1,q2):
    '''
    Calculates the manhattan distance given the two points in the cartesian plane
    Parameters:
        p1,p2: (int) - the starting point in the plane in x and y coordinates
        q1,q2: (int) - the ending point in the plane in x and y coordinates
    Returns:
        total sum of horizontal and vertical components: (int)
    '''
    distance = abs(p1 -q1) + abs(p2 - q2)
    return distance

assertEqual(calculate_manhattan_distance(5,4,6,9),6)
assertEqual(calculate_manhattan_distance(7,7,8,8),2)
assertEqual(calculate_manhattan_distance(4,8,9,0),13)        