# This is where you will write your code for Lab 5 Part C
# Do not delete these lines
from cisc106 import *
from customIO import *
from functions import *

# ---------------------------------------------------------
# Lab 5 - Part C
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Lab 4 E - Testing Functions
# ----------------------------------------------

# Problem 21 - Assert Equal for sum_between function
assertEqual(sum_between([14,80,90,40],30,100),210)
assertEqual(sum_between([-5,-4,-3,-2,-1,0,1,2,3,4,5],6,7),0)
assertEqual(sum_between([-16,89,-33,2,43],-20,20),-14)

# ----------------------------------------------
# Problem 22 - Assert Equal for weighted_total function
assertEqual(weighted_total([1,2,3],[0.1,0.1,0.1]),0.6)
assertEqual(weighted_total([56,21,4,56],[2,3,4,5]),471)
assertEqual(weighted_total([-32,87,32,-0.1],[0,1,2,3]),150.7)

# ----------------------------------------------
# Problem 23 - Assert Equal for count_odds_ints function
assertEqual(count_odd_ints([3,7.0,5.1,2]),1)
assertEqual(count_odd_ints(["hi",0.1,0,4]),0)
assertEqual(count_odd_ints(["hello",3,5,9,10.4]),3)

# ----------------------------------------------
# Problem 24 - Assert Equal for round_list function
assertEqual(round_list([3.14159,0.90,8],1),[3.1,0.9,8.0])
assertEqual(round_list([1,2,3,4],1),[1.0,2.0,3.0,4.0])
assertEqual(round_list([9.56,7.6,3.51],1),[9.6,7.6,3.5])



