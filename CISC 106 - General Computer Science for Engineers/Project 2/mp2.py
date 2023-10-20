# This is where you will write your code for Project 2 - final submission
# ---------------------------------------------------------
# Project #2 - Soft Landing - final submission
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Mini Project #2 - Final submission
# ----------------------------------------------

import matplotlib
from matplotlib import pyplot as plt
from functions import *

#------------------------------------------------
GRAVITY = 1.622     # assumed to be m/s**2, gravity of the moon
POWER = 4.0         # amount of thrust received for each unit of fuel expended
STRENGTH_INIT = 4   # lander's strength

#------------------------------------------------
# Optional Function 1
def get_integer(maximum,prompt):
    '''
    Returns a valid integer value given the prompt and the maximum value
    Parameters:
        maximum: (int) - the integer should be in between 0 and maximum value
        prompt: (str) - the instruction as the message to the user
    Return:
        valid_int: (int) - a valid integer value
    '''
    keep_going = True
    users_question = "Enter a valid integer value: "
    while keep_going:
        # for a string prompt that only has digits (non-negative integers),...
        # ...compare it to the maximum value for its valid integer value
        if prompt.isdigit() == True:
            
            # return the prompt in integer if it is in between the maximum value and 0
            if maximum >= 0 and int(prompt) <= maximum:
                valid_int = int(prompt)
                return valid_int
                
            # asks the user for another integer value if the prompt in integer is more than the maximum value
            elif maximum >= 0 and int(prompt) > maximum:
                prompt = input(users_question)
                
            # return the prompt in integer directly if the maximum is less than 0
            elif maximum < 0:
                valid_int = int(prompt)
                return valid_int
                
        # for a string prompt that has other than non-negative integers, keep on asking the user for a valid integer
        elif prompt.isdigit() == False:
            prompt = input(users_question)

# ----------------------------------------------            
# Optional Function 2
def is_float(s):
    '''
    Determines whether the given string s can be turned into a float or not
    Parameter:
        s: (str) - any string
    Return:
        truth: (bool) - True if can be turned into a float or False otherwise
    '''   
    # for a string that has a possible float value, return True to indicate...
    # ...a valid float value or False otherwise
    try:
        float(s)
        truth = True
        return truth
    except ValueError:
        truth = False
        return truth

# ----------------------------------------------            
# Optional Function 3
def get_float(prompt):
    '''
    Returns a valid float value given the prompt as the message to the user
    Parameter:
        prompt: (str) - a prompt as the message to the user
    Return:
        valid_float: (float) - a valid float value
    '''
    keep_going = True
    while keep_going:
        
        # for a prompt that has a valid float value, return the prompt in float
        if is_float(prompt) == True:
            valid_float = float(prompt)
            return valid_float
        
        # for a prompt that has no valid float value, ask the user again until a valid float value is entered
        else:
            prompt = input("Enter a valid float value: ")

# ----------------------------------------------            
# Optional Function 4
def get_history_filename(landing_num):
    '''
    Returns a string of the name of the file given the landing_num
    Parameter:
        landing_num: (int) - the number of current landing attempt
    Return:
        statement: (str) - a string of the name of the file in format 'LandingNN.csv', where NN
        represents the two digits of the current landing attempt
    '''
    # for the number of landing attempt between 0 and 10 (not inclusive), use the following statement
    if landing_num >= 0 and landing_num < 10:
        string_landing_num = str(landing_num)
        statement = "Landing0" + string_landing_num + ".csv"
        
    # for the number of landing attempt between 10 and 99 (inclusive), use the following statement
    else:
        string_landing_num = str(landing_num)
        statement = "Landing" + string_landing_num + ".csv"
        
    return statement

# ----------------------------------------------
# Required Function 1
def get_initial_conditions():
    '''
    Asks the user for the initial altitude, speed and amount of fuel and returns those three in a list
    Parameter:
        None
    Return:
        lists: (list) - a list containing initial altitude, speed and amount of fuel (in that order)
    '''
    # asks the user for the initial altitude and check whether the altitude has a valid float value or not
    prompt_altitude = input("Enter the lander's initial altitude: ")
    initial_altitude = get_float(prompt_altitude)
    
    # altitude cannot take a negative value, hence, if the user input a negative value, 
    # ...we should ask the user again until a non-negative value is entered
    if initial_altitude < 0:
        while initial_altitude < 0:
            prompt_altitude = input("Enter a valid float value: ")
            initial_altitude = get_float(prompt_altitude)
    
    # asks the user for the initial speed and check whether the speed has a valid float value or not        
    prompt_speed = input("Enter the lander's initial speed: ")
    initial_speed = get_float(prompt_speed)
    
    # asks the user for the initial fuel amount and check whether the fuel amount has a valid integer value or not
    prompt_fuel = input("Enter the lander's initial fuel: ")
    initial_fuel_amount = get_integer(100,prompt_fuel)
    
    # concatenate the initial altitude, initial speed and initial fuel amount (in that order) into a list
    lists = [initial_altitude, initial_speed, initial_fuel_amount]
    
    return lists

# ----------------------------------------------
# Required Function 2
def save_history(history_list,landing_num):
    '''
    Writes the sublists in its own line in a file given the history_list and landing_num
    Parameters:
        history_list: (list) - a nested list, where the sublists are written in its own line in a file
        landing_num: (int) - a number of current landing attempt
    Return:
        None
    '''
    # creating a name for the filename by calling the get_history_function
    filename = get_history_filename(landing_num)
    
    # open the file for writing and write the length of the history_list on the first line
    new_file = open(filename,"w")
    number_of_sublists = str(len(history_list))
    new_file.write(number_of_sublists + "\n")
    
    # looping through the sublists in the history_list to write the elements in the file
    for index1 in range(len(history_list)):
        statement = ""
        
        for index2 in range(len(history_list[index1])):
            # creating a line statement for every line in the file,...
            # ...containing the elements in each sublists, separated with comma
            statement += str(history_list[index1][index2]) + ","
            
        # every line has a comma at the very end, use the strip method to strip away the comma    
        new_file.write(statement.strip(",") + "\n")  
        
    # close the file after writing
    new_file.close()

# ----------------------------------------------
# Required Function 3
def get_response(valid_entries,prompt):
    '''
    Asks the user for a single character and returns the lower case character if the character matches one of the characters in the given valid_entries
    Parameters:
        valid_entries: (str) - a string that is being compared to with the user's input
        prompt: (str) - a prompt as the message to the user
    Return:
        response.lower() - (str) - a lower case character that matches one of the characters in the valid_entries
    '''
    # asks the user for a response by using the prompt given as the message to the user
    response = input(prompt)
    
    keep_going = True
    while keep_going:
        
        # user should only input a single character, hence, if the response's length is not 1,...
        # ...we should ask the user again until a single character is entered
        if len(response) != 1:
            response = input(prompt)
            
        # if a single character is entered by the user, we have to check whether the character...
        # ...matches with any of the characters in the valid_entries
        else:
            for characters in valid_entries:
                if response.upper() == characters or response.lower() == characters:
                    
                    # if the response matches with one of the characters in valid_entries,...
                    # ...return the response in lower case
                    return response.lower()
                    
            # asks the user again if there is no match to any character in the valid_entries
            response = input(prompt)

# ----------------------------------------------
# Plotting Function
def plot_history(history_list):
    '''
    Plot a line graph of altitude, speed and fuel over time in that order
    Parameter:
        history_list: (list) - a nested list of history data for a simulation
    Return:
        None
    '''
    x_values = range(len(history_list))
    # a list of time in seconds of one landing simulation
    # every sublist in the history_list refers to every second of the spaceship trying to land
    
    y_values_alt = []
    # initializing an empty list of altitude of the spaceship per second before landing
    # subsequently being added every second in the for loops before reaching the ground
    
    y_values_speed = []
    # initializing an empty list of speed of the spaceship per second before landing
    # subsequently being added every second in the for loops before reaching the ground
    
    y_values_fuel = []
    # initializing an empty list of fuel left in the spaceship per second before landing
    # subsequently being added every second in the for loops before reaching the ground
    
    # using for loops to go through every elements in every sublist and...
    # ... put it in its respective list above, either altitude, speed or fuel
    for index1 in range(len(history_list)):
        for index2 in range(len(history_list[index1])):
            
            if index2 == 0:
            # the first element in every sublist refers to altitude
                y_values_alt += [history_list[index1][0]]
                
            elif index2 == 1:
            # the second element in every sublist refers to speed
                y_values_speed += [history_list[index1][1]]
                
            elif index2 == 2:
            # the third element in every sublist refers to fuel
                y_values_fuel += [history_list[index1][2]]
                
    fig, ax = plt.subplots()
    # creating a reference to the figure and axes
    
    ax.plot(x_values,y_values_alt,color = "b",marker = "s",label = "altitude m")
    ax.plot(x_values,y_values_speed,color = "r",marker = "o",label = "speed m/s")
    ax.plot(x_values,y_values_fuel,color = "g",marker = "*",label = "fuel units")
    # plotting the data for altitude, speed and fuel (in that order) with different colors, markers and labelling
    # assigned altitude with blue line, with square markers and labelled as 'altitude m'
    # assigned speed with red line, with circle markers and labelled as 'speed m/s'
    # assigned fuel with green line, with star markers and labelled as 'fuel units'
    
    ax.legend()
    ax.grid()
    # to make the labelling and gridlines appear in the figure 
    
    plt.xlabel("Time - seconds")
    plt.title("Statistics of Lander Simulation")
    # the x-axis is labelled as 'Time - seconds' and the figure's title is 'Statistics of Lander Simulation'
    
    plt.show()
    # to display the figure

# ----------------------------------------------
# Main Function
def main():
    '''
    Controls the entire spaceship simulation in manual mode
    Parameter: 
        None
    Return:
        None
    '''
    print("Hello, there!!! Welcome to my Spaceship simulator!!")
    # greets the user at the start of the game
    
    keep_going = True
    landing_attempts = 1
    # the landing_attempts is initialized as 1 as the startof the simulation
    
    while keep_going:
        
        initial_thrust = 0
        
        alt_speed_fuel_list = get_initial_conditions()
        # the initial value of altitude, speed and fuel were asked from the user and the returned list is assigned to alt_speeed_fuel_list
        
        history_data_list = [alt_speed_fuel_list + [initial_thrust]]
        # a list of history data is created by concatenating the alt_speed_fuel_list with the initial thrust and assigned it to history_data_list
        
        current_altitude = alt_speed_fuel_list[0] # the first element in the alt_speed_fuel_list refers to altitude and assigned it to current_altitude
        current_speed = alt_speed_fuel_list[1]    # the second element in the alt_speed_fuel_list refers to speed and assigned it to current_speed
        current_fuel = alt_speed_fuel_list[2]     # the third element in the alt_speed_fuel_list refers to fuel and assigned it to current_fuel
        pilot_strength = STRENGTH_INIT            # the lander's strength is assigned to pilot_strength
        
        response = get_manual_or_automatic()
        # asking the user for a manual or automatic mode (in this project, no automatic simulation is required)
        
        if response == 'm':
        # for a mnual simulation
            
            show_status(current_altitude,current_speed,current_fuel,pilot_strength)
            # display the initial status for all of the following variables to the user
            
            while current_altitude > 0:
            # indicates that the spaceship still in the air, and will stop the loop when it has landed
    
                current_thrust_amount = get_thrust_from_user(current_altitude,current_speed,current_fuel,pilot_strength)
                # ask the user for thrust value from get_thrust_from_user function and assigned it to a new variable named current_thrust_amount
        
                speed_change,fuel_used = apply_thrust(current_thrust_amount,current_fuel,pilot_strength)
                # use the thrust value obtained from user into apply_thrust function, in which it will return the speed change and the amount of used-up fuel
                # assigned the return values to variables named speed_change and fuel_used respectively
        
                current_speed = current_speed - speed_change
                current_fuel = current_fuel - fuel_used
                # the speed affected by the thrust and the remaining fuel are calculated by using the value of speed_change and fuel_used
        
                current_altitude,current_speed = update_one_second(current_altitude,current_speed)
                # the new altitude and the speed affected by the gravity are calculated and assigned to variables named current_altitude and current_speed respectively
        
                show_status(current_altitude,current_speed,current_fuel,pilot_strength)
                # display again the current status for all of the following variables to the user
        
                history_data_list.append([current_altitude,current_speed,current_fuel,current_thrust_amount])
                # the new altitude, speed, fuel and thrust value are added into the history_data_list 
        
                save_history(history_data_list,landing_attempts)
                # the data in the history_data_list should be kept in a file by using the save_history function
            
            report_landing(current_speed,pilot_strength)
            # display the landing status of the spaceship to the user after landing
            
            # another while loops is needed because the user needs to choose either to quit the program after one round of landing, ...
            # ... to run it for another round, or to plot the graph based on the current attempts of landing
            keep_asking = True
            while keep_asking:
                prompt = "Enter 'q' to quit, 'a' to start again, or 'p' to plot the graph: "
                response = get_response("qap",prompt)
                # to check a valid response given by the user
                # should only return either 'q', 'a' or 'p'
                
                if response == "q":
                    keep_asking = False    # This while loops is terminated
                    keep_going = False     # The big while loops is terminated in order to stop ...
                                           # ... the simulation and will straight away go to the end
                                          
                elif response == "a":
                    keep_asking = False    # This while loops is terminated
                    keep_going = True      # But, the simulation will restart and will begin by ...
                                           # ... asking for the values again from the user
                    landing_attempts += 1  # The number of attempts is increased by 1
                    
                elif response == "p":
                    plot_history(history_data_list)  # The data at that current attempt is plotted
                    keep_asking = True               # Once the data is plotted, the user is asked again ...
                                                     # ... to either quit, restart or plot again
   
    print("Thank you for playing. Have a great day!!") 
    # message to the user after the end of the game