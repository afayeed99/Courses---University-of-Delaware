# This is where you will write your code for Lab 4 Part E
# Do not delete these lines
from cisc106 import *
from customIO import *
from functions import *

# ---------------------------------------------------------
# Lab 4 - Part E
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Lab 4 E - Testing Functions
# ----------------------------------------------

# Problem 11 - Assert Equal for factorial function
assertEqual(factorial(4),24)
assertEqual(factorial(0),1)
assertEqual(factorial(-9),None)

# ----------------------------------------------
# Problem 12 - Assert Equal for function of summing integers
assertEqual(my_sum(5),15)
assertEqual(my_sum(3),6)
assertEqual(my_sum(10),55)

# ----------------------------------------------
# Problem 13 - Assert Equal for function of sum of squares
assertEqual(sum_squares(1,4),30)
assertEqual(sum_squares(3,5),50)
assertEqual(sum_squares(2,8),203)

# ----------------------------------------------
# Problem 14 - Assert Equal for function of number of perfect squares
assertEqual(num_perfect_sq(5),2)
assertEqual(num_perfect_sq(9),3)
assertEqual(num_perfect_sq(14),3)

# ----------------------------------------------
# Problem 15 - Assert Equal for function of summing perfect squares
assertEqual(sum_perfect_sq(5),5)
assertEqual(sum_perfect_sq(9),14)
assertEqual(sum_perfect_sq(14),14)