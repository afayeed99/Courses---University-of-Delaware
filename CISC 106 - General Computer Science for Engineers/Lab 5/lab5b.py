# This is where you will write your code for Lab 5 Part B
# Do not delete these lines
from cisc106 import *
from customIO import *

# ---------------------------------------------------------
# Lab 5 - Part B#
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Lab 5 - Lists
# ----------------------------------------------

# Problem 20 - Function that prints the histogram using asterisks to represent the numbers in the list
def print_histogram(number_list):
    '''
    Prints a histogram graph using asterisks to represent each number in the list of numbers given the list
    Parameter:
        number_list: (list) - list of integers
    Return:
        None
    '''
    for integers in number_list:
        if integers >= 0:
            print(integers * "*")

# ----------------------------------------------
# Problem 21 - Function that determines the sum of integers in the list between the given bounds 
def sum_between(list_of_numbers,lower_bound,upper_bound):
    '''
    Calculates the sum of numbers in the list of numbers between two bounds inclusively given the list and two bounds
    Parameters:
        list_of_numbers: (list) - list of integers
        lower_bound: (int) - the lower bound 
        upper_bound: (int) - the upper bound
    Return:
        sum: (int) - the sum of integers
    '''
    sum = 0
    for integers in list_of_numbers:
        if integers >= lower_bound and integers <= upper_bound:
            sum = sum + integers
    return sum

assertEqual(sum_between([14,80,90,40],30,100),210)
assertEqual(sum_between([-5,-4,-3,-2,-1,0,1,2,3,4,5],6,7),0)
assertEqual(sum_between([-16,89,-33,2,43],-20,20),-14)

# ----------------------------------------------
# Problem 22 - Function that calculates the total weights in the list
def weighted_total(number_list,weights):
    '''
    Calculates the weighted total of a list of numbers given the list and their respective weights
    Parameters:
        number_list: (list) - list of numbers
        weights: (list) - list of weights 
    Return:
        sum: (int) - the sum of the product of numbers in the list and its respective weights
    '''
    sum = 0
    n = 0
    for numbers in number_list:
        sum = sum + numbers * weights[n]
        n += 1
    return sum
    
assertEqual(weighted_total([1,2,3],[0.1,0.1,0.1]),0.6)
assertEqual(weighted_total([56,21,4,56],[2,3,4,5]),471)
assertEqual(weighted_total([-32,87,32,-0.1],[0,1,2,3]),150.7)
        
# ----------------------------------------------
# Problem 23 - Function that counts the number of odd integers in the list
def count_odd_ints(list):
    '''
    Returns the number of odd integers in the list of any type of datas given the list
    Parameter:
        list: (list) - a list of any type of datas (consist of not only integers)
    Return:
        counter: (int) - number of odd integers in the list
    '''
    counter = 0
    for elements in list:
        if type(elements) == int and elements % 2 != 0:
            counter += 1
    return counter
        
assertEqual(count_odd_ints([3,7.0,5.1,2]),1)
assertEqual(count_odd_ints(["hi",0.1,0,4]),0)
assertEqual(count_odd_ints(["hello",3,5,9,10.4]),3)

# ----------------------------------------------
# Problem 24 - Function that rounds the numbers in the list to the nearest given decimals
def round_list(float_list,decimals):
    '''
    Rounds the floats in the list of float to the nearest decimals given the list and decimals
    Parameters:
        float_list: (list) - a list of floats
        decimals: (int) - the number of decimal places that the float rounded to
    Return:
        new_float_list: (list) - a new list containing the rounded float
    '''
    new_float_list = []
    for number in float_list:
        rounded_float = round(number,decimals)
        new_float_list.append(rounded_float)
    return new_float_list
    
assertEqual(round_list([3.14159,0.90,8],1),[3.1,0.9,8.0])
assertEqual(round_list([1,2,3,4],1),[1.0,2.0,3.0,4.0])
assertEqual(round_list([9.56,7.6,3.51],1),[9.6,7.6,3.5])