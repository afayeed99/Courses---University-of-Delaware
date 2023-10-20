# This is where you will write your code for Lab 4 Part C
# Do not delete these lines
from cisc106 import *
from customIO import *

# ---------------------------------------------------------
# Lab 4 - Part C
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Lab 4 - While Loops
# ----------------------------------------------

# Problem 11 - Function that returns the factorial of an integer
def factorial(integer):
    '''
    Returns the factorial of a given integer
    Parameter:
        integer : (int) - any integer
    Return:
        number : (int) - the factorial of the integer, 1 or None
    '''
    number = 1
    counter = 0
    if integer > 0:
        while counter < integer:
            counter += 1
            number = number * counter
        return number
    elif integer == 0:
        return 1
    else:
        return 
    
assertEqual(factorial(4),24)
assertEqual(factorial(0),1)
assertEqual(factorial(-9),None)

# ----------------------------------------------
# Problem 12 - Function that calculates the sum of the integers
def my_sum(integer):
    '''
    Calculates the sum of all integers between 0 and 'integer'
    Parameter:
        integer : (int) - non-negative integer
    Return:
        sum : (int) - the sum of the integers between 0 and 'integer'
    '''
    count = 0
    sum = 0
    while count < integer:
        count += 1
        sum = sum + count
    return sum
    
assertEqual(my_sum(5),15)
assertEqual(my_sum(3),6)
assertEqual(my_sum(10),55)

# ----------------------------------------------
# Problem 13 - Function the calculates the sum of squares 
def sum_squares(start,finish):
    '''
    Calculates the sum of squares of all integers between start and finish integers given the start and finish
    Parameters:
        start: (int) - an integer
        finish: (int) - an integer
    Return:
        sum: (int) - total sum of the squares of all integers between start and finish (inclusive) 
    '''
    sum = 0
    while start <= finish:
        sum = sum + (start ** 2)
        start += 1
    return sum

assertEqual(sum_squares(1,4),30)
assertEqual(sum_squares(3,5),50)
assertEqual(sum_squares(2,8),203)

# ----------------------------------------------
# Problem 14 - Function that determines the number of perfect squares
def num_perfect_sq(max):
    '''
    Determines the number of perfect squares between 1 and max (inclusive)
    Parameter:
        max : (int) - a maximum positive integer
    Return:
        total_perfect_sq : (int) - number of perfect squares between 1 and max (inclusive)
    '''
    total_perfect_sq = 0
    number = 1
    while number <= max:
        if number % (number ** (1 / 2)) == 0:
            total_perfect_sq += 1
            number += 1
        elif number % (number ** (1 / 2)) != 0:
            number += 1
    return total_perfect_sq
    
assertEqual(num_perfect_sq(5),2)
assertEqual(num_perfect_sq(9),3)
assertEqual(num_perfect_sq(14),3)
    
# ----------------------------------------------
# Problem 15 - Function that calculates the sum of perfect squares
def sum_perfect_sq(max):
    '''
    Calculates the sum of perfect squares between 1 and max (inclusive)
    Parameter:
        max : (int) - a maximum positive integer
    Return:
        sum : (int) - sum of perfect squares between 1 and max (inclusive)
    '''
    sum = 0
    number = 1
    while number <= max:
        if number % (number ** (1 / 2)) == 0:
            sum = sum + number
            number += 1
        elif number % (number ** (1 / 2)) != 0:
            number += 1
    return sum
    
assertEqual(sum_perfect_sq(5),5)
assertEqual(sum_perfect_sq(9),14)
assertEqual(sum_perfect_sq(14),14)

# ----------------------------------------------
# Problem 16 - Function that returns the string hey, ho or hey-ho
def hey_ho(num):
    '''
    Prints the numbers from 1 to num replacing the multiples of 3 or 4 with hey or ho respectively, and multiples of 3 and 4 with hey-ho
    Parameter:
        num : (int) - an integer
    Return:
        None
    '''
    count = 1
    while count <= num:
        if count % 3 == 0 and count % 4 != 0:
            print ("hey")
            count += 1
        elif count % 3 != 0 and count % 4 == 0:
            print("ho")
            count += 1
        elif count % 3 == 0 and count % 4 == 0:
            print("hey-ho")
            count += 1
        else:
            print(count)
            count += 1

# ----------------------------------------------
# Problem 17 - Function that lists down the real fibonacci number sequence
def fibonacci(count):
    '''
    Prints the fibonacci number for the first nth term
    Parameter:
        count : (int) - maximum number of terms in fibonacci number sequence
    Return:
        None
    '''
    term1 = 0
    print(term1)
    term2 = 1
    print(term2)
    number = 2
    while number < count:
        term3 = term1 + term2
        print(term3)
        number += 1
        term1 = term2
        term2 = term3

# ----------------------------------------------
# Problem 18 - Function that lists down the made up fibonacci number sequence
def gen_fibonacci(term1,term2,count):
    '''
    Prints the fibonacci number for the first nth term
    Parameter:
        term1 : (int) - the first term in the sequence
        term2 : (int) - the second term in the sequence
        count : (int) - the number of terms needed to be listed down
    Return:
        None
    '''
    print(term1)
    print(term2)
    number = 2
    while number < count:
        term3 = term1 + term2
        print(term3)
        number += 1
        term1 = term2
        term2 = term3