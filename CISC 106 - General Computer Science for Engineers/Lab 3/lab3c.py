# This is where you will write your code for Lab 3 Part C
# Do not delete these lines
from cisc106 import *

# ---------------------------------------------------------
# Lab 3 - Part C
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Lab 3 - Debugging Functions 
# ----------------------------------------------

# Problem 24 - Debugging the problem given

def total_purchase(num_adult, num_child):
    '''
    Computes the total price of movie tickets
    Parameters:
        num_adult: (int) - number of adult's tickets being purchased
        num_child: (int) - number of child's tickets being purchased
    Returns:
        total cost: (float)
    '''
    total_adult  = num_adult * 10.0
    total_child  = num_child * 7.5
    total = total_adult + total_child
    if total >= 50:  
        total = total * 0.8
    elif total >= 40 and total < 50:
        total = total * 0.85
    elif total >= 30 and total < 40:
        total = total * 0.9
    return total

assertEqual(round(total_purchase(2,4),2),40.00)
assertEqual(round(total_purchase(4,1),2),40.38)
assertEqual(round(total_purchase(0,4),2),27.00) 