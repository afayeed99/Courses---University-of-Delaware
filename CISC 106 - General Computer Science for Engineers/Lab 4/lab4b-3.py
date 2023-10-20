# This is where you will write your code for Lab 4 Part B
# Do not delete these lines
from cisc106 import *
from customIO import *
from functions import *

# ---------------------------------------------------------
# Lab 4 - Part B
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Lab 4 - While Loops
# ----------------------------------------------

# Problem 7 - Function which return a True or False
def yes_or_no():
    '''
    Returns a boolean True or False
    Parameter:
        None
    Returns:
        True or False : (bool)
    '''
    keep_asking = True
    while keep_asking:
        command = input("Enter a 'yes' or a no': ")
        if command == "yes":
            return True
            keep_asking = False
        elif command == "no":
            return False
            keep_asking = False
        else:
            keep_asking = True

# ----------------------------------------------
# Problem 8 - Function which returns the total value of the input integers
def running_total():
    '''
    Determines the total value of integers
    Parameter:
        None
    Return:
        integer : (int) - sum of the input integers
    '''
    integer = 0
    keep_going = True
    while keep_going:
        command = input("Enter an integer or enter 'done' to quit: ")
        if str(command) == "done":
            keep_going = False
        elif int(command) >= 0 or int(command) < 0:
            integer = integer + int(command)
        else:
            keep_going = True
    return integer
 
# ----------------------------------------------   
# Problem 9 - Function which returns the average value of the input integers
def running_average():
    '''
    Calculates the average value of the input integers
    Parameter:
        None
    Return:
        average : (float) - the average value of input integers
    '''
    keep_going = True
    counter = 0
    total = 0
    while keep_going:
        command = input("Enter an integer or enter 'done' to quit: ")
        if str(command) == "done":
            keep_going = False
        elif int(command) >= 0 or int(command) < 0:
            total = total + int(command)
            counter = counter + 1
            keep_going = True
        else:
            keep_going = True
    
    # when the user inputs 'done' at first        
    if counter == 0:          
        counter = counter + 1

    average = total / counter
    return average

# ----------------------------------------------
# Problem 10 - Function which returns the prime number
def main():
    '''
    Returns a list of prime number for the first nth term (the input integers)
    Parameter:
        None
    Return:
        None
    '''
    counter = 0
    number = 2
    integer = int(input("Enter a positive integer: "))
    while counter < integer:
        if is_prime(number) == True:
            print(number)
            number += 1
            counter += 1
        elif is_prime(number) == False:
            number += 1