# This is where you will write your code for Lab 6 Part B
# Do not delete these lines
from cisc106 import *
from customIO import *

# ---------------------------------------------------------
# Lab 6 - Part B#
# ---------------------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Lab 6 - Lists and Strings
# ---------------------------------------------------------

# Problem 14 - Function that reverses the string
def reverse_string(string):
    '''
    Reverses the string given the string
    Parameter:
        string: (str) - a string
    Return:
        string_in_reverse: (str) - a reversed string
    '''
    string_in_reverse = ""
    for letters in string:
        string_in_reverse = letters + string_in_reverse
    return string_in_reverse
    
assertEqual(reverse_string("Fayeed"),"deeyaF")
assertEqual(reverse_string("b0Bby"),"ybB0b")
assertEqual(reverse_string("cisc is fun"),"nuf si csic")

# ---------------------------------------------------------
# Problem 15 - Function that locates the last index of letter W in the string
def locate_W(string):
    '''
    Returns the last index number of letter W in the string given the string
    Parameter:
        string: (str) - a string
    Return:
        last_index: (int) - the last index number of letter W
    '''
    last_index = None
    for index in range(len(string)):
        if string[index] == "W":
            last_index = index
    return last_index

assertEqual(locate_W("What is your name?"),0)
assertEqual(locate_W("who is will smith?"),None)
assertEqual(locate_W("Willy Wonka is scary"),6)

# ---------------------------------------------------------
# Problem 16 - Function that counts the number of letter W in the string
def count_W(string):
    '''
    Counts the number of letter W in the string given the string
    Parameter:
        string: (str) - a string
    Return:
        count: (int) - the number of letter W in the string
    '''
    count = 0
    for letters in string:
        if letters == "W":
            count += 1
    return count

assertEqual(count_W("Wow, that's amazing Will!!"),2)
assertEqual(count_W("That's okay Fayeed"),0)
assertEqual(count_W("what's wrong with you?"),0)

# ---------------------------------------------------------
# Problem 17 - Function that separates the string by the letter r
def cut_string(string):
    '''
    Returns a string that was split by the letter r given the string
    Parameter:
        string: (str) - a string which contains letter r
    Return:
        split_string: (list) - a list which contains strings that were split by letter r
    '''
    split_string = string.split("r")
    return split_string
    
assertEqual(cut_string("How are you?"),["How a","e you?"])
assertEqual(cut_string("I'm fine. Thanks for asking"),["I'm fine. Thanks fo"," asking"])
assertEqual(cut_string("I hate you so much!!"),["I hate you so much!!"])

# ---------------------------------------------------------
# Problem 18 - Function that returns a string which has a combination of two strings of the same length
def interleave(string1,string2):
    '''
    Returns a string with the first character of the first string followed by the first character of the second string and continues until the end given two strings of the same length
    Parameters:
        string1: (str) - a string of the same length as string2
        string2: (str) - a string of the same length as string1
    Return:
        new_string: (str) - a string with the two strings interleaved together
    '''
    new_string = ""
    for index in range(len(string1)):
        new_string += string1[index] + string2[index]
    return new_string
    
assertEqual(interleave("Fayeed","Bobbby"),"FBaoybebebdy")
assertEqual(interleave("CISC","funn"),"CfIuSnCn")
assertEqual(interleave("I hate you","I like you"),"II  hlaitkee  yyoouu")

# ---------------------------------------------------------
# Problem 19 - Function that counts the vowels in the string
def count_vowels(string):
    '''
    Counts the vowels in the string given the string
    Parameter:
        string: (str) - a string
    Return:
        count: (int) - the number of vowels in the string
    '''
    count = 0
    for letters in string:
        if letters == "a" or letters == "A":
            count += 1
        elif letters == "e" or letters == "E":
            count += 1
        elif letters == "i" or letters == "I":
            count += 1
        elif letters == "o" or letters == "O":
            count += 1
        elif letters == "u" or letters == "U":
            count += 1
    return count

assertEqual(count_vowels("Fayeed"),3)
assertEqual(count_vowels("COMPUTER SCIENCE"),6)
assertEqual(count_vowels("rhythm"),0)

# ---------------------------------------------------------
# Problem 20 - Function that returns a string of characters representing the booleans in the given list
def bools_2_str(list_of_bools):
    '''
    Returns a string of characters representing the booleans in the list given the list of booleans
    Parameter:
        list_of_bools: (list) - a list of booleans
    Return:
        new_string: (str) - a string of characters representing the booleans where "X" represents True while " " represents False
    '''
    new_string = ""
    for bools in list_of_bools:
        if bools == True:
            new_string += "X"
        elif bools == False:
            new_string += " "
    return new_string

assertEqual(bools_2_str([True,True,True,False,False,True]),"XXX  X")
assertEqual(bools_2_str([False,True])," X")
assertEqual(bools_2_str([False,False]),"  ")

# ---------------------------------------------------------
# Problem 21 - Function that determines any duplicates in the given list
def has_duplicates(lists):
    '''
    Determines whether there are any duplicates in the list or not given the list
    Parameter:
        lists: (list) - a list of any type
    Return:
        truth: (bool) - True if there is a duplicate or False if there is no duplicate or it's an empty list
    '''
    if lists == []:
        truth = False
    else:
        for index1 in range(len(lists)):
            for index2 in range(index1 + 1,len(lists)):
                if lists[index1] == lists[index2]:
                    truth = True
                    return truth
                elif lists[index1] != lists[index2]:
                    truth = False
    return truth

# ---------------------------------------------------------
# Problem 22 - Function that returns characters of the string whose position is the same as True in the booleans list
def mask_encode(list_of_bool,string):
    '''
    Returns the characters of the string whose position is the same as True in the booleans list given the list of booleans and string
    Parameters:
        list_of_bool: (list) - a list of booleans
        string: (str) - a string
    Return:
        new_string: (str) - a string with characters from the original string whose position is the same as True in the booleans list
    '''
    new_string = ""
    for index in range(len(string)):
        if list_of_bool[index] == True:
            new_string += string[index]
    return new_string
    
assertEqual(mask_encode([True,False,True],"hey"),"hy")
assertEqual(mask_encode([True,False,True,False,False,False,True],"Fayeed"),"Fy")
assertEqual(mask_encode([True,False],""),"")

# ---------------------------------------------------------
# Problem 23 - Function that counts the number of even numbers in the nested list
def count_evens_NxN(nested_list):
    '''
    Counts the number of even numbers in the nested list given the list
    Parameter:
        nested_list: (list) - a nested list of integers
    Return:
        count: (int) - the number of even numbers in the list
    '''
    count = 0
    for list in nested_list:
        for index in range(len(list)):
            if list[index] == 0 or list[index] % 2 == 0:
                count += 1
    return count

assertEqual(count_evens_NxN([[1,2],[4,6]]),3)
assertEqual(count_evens_NxN([[0,2,4],[1,3,5],[10,35,42]]),5)
assertEqual(count_evens_NxN([[0,5],[4,6]]),3)

# ---------------------------------------------------------
# Problem 24 - Function that returns the absolute difference between the sum of the diagonals of the list
def diagonal_diff(nested_list):
    '''
    Returns the absolute difference between the sum of the diagonals of the nested list given the nested list
    Parameter:
        nested_list: (list) - a list of lists of which has an NxN matrix of numbers
    Return:
        absolute_difference: (int) - the absolute difference in between the diagonals of the nested list
    '''
    sum1 = 0
    sum2 = 0
    for index1 in range(len(nested_list)):
        sum1 += nested_list[index1][index1]
    for index2 in range(len(nested_list)):
        nested_list[index2].reverse()
        sum2 += nested_list[index2][index2]
    absolute_difference = abs(sum1 - sum2)
    return absolute_difference

assertEqual(diagonal_diff([[1,2],[3,4]]),0)
assertEqual(diagonal_diff([[1,2,3],[4,5,6],[7,8,9]]),0)
assertEqual(diagonal_diff([[2,2,2,2],[3,3,3,3],[4,4,4,4],[5,5,5,5]]),0)

# ---------------------------------------------------------
# Problem 25 - Function that rounds a float to the nearest decimals of given positive integer
def round_list(lists,positive_integer):
    '''
    Returns the modified list where the floats in the list has been rounded up to the nearest decimals of the given positive integer while maintaining other types of data in the list 
    Parameters:
        lists: (list) - a list of any type of data (including lists)
        positive_integer: (int) - a number that the floats in the list should be rounded to (the nearest decimals)
    Return:
        None
    '''
    for index1 in range(len(lists)):
        if type(lists[index1]) == float:
            lists[index1] = round(lists[index1],positive_integer)
        elif type(lists[index1]) == list:
            round_list(lists[index1],positive_integer)

assertEqual(round_list([1.03,[1,2.0,3],"hi"],1),None)
assertEqual(round_list(["hey",[True,False,3],"hi"],1),None)
assertEqual(round_list([3.56,[8.98,7.6,9],9.0],1),None)
