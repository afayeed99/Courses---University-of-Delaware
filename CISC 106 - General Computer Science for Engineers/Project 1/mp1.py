# This is where you will write your code for your final submission
# ---------------------------------------------------------
# Mini Project #1 - Soft Landing - Final Submission
# ----------------------------------------------
# Student Name: Abdul Fayeed Abdul Kadir
# Lab Section Number: 031L
# Partner Name: Robert McCulley
# Partner UDID: 702466861
# Mini Project #1 - Final Submission
# ----------------------------------------------

import math

# These are your constants. Leave them here.
GRAVITY = 1.622    # assumed to be m/s**2. This is the gravity of the moon.
POWER = 4.0        # This is the amount of thrust received for each unit of fuel expended.
ALT_INIT = 100.0   # The lander's initial altitude in meters.
SPEED_INIT = 30.0  # The lander's initial speed in m/s.
FUEL_INIT = 20     # The lander's initial fuel.
STRENGTH_INIT = 4  # The lander's strength (won't change in this program)

# ----------------------------------------------------------
# Function 1 - Function that returns the change in speed and the amount of fuel used up
def apply_thrust(thrust_amount,fuel,strength):
    '''
    Returns the change in speed and the amount of fuel used up given the amount of thrust, amount of fuel left and the strength of the pilot
    Parameters:
        thrust_amount: (int) - amount of thrust applied
        fuel: (int) - amount of fuel left
        strength: (int) - the strength of the pilot
    Returns:
        speed_change: (float) - the value of change in speed
        fuel_used: (int) - the amount of fuel being used up
    '''
    if thrust_amount > fuel or thrust_amount > strength:
        if fuel > strength:
            thrust_amount = strength
        elif fuel < strength:
            thrust_amount = fuel
        elif fuel == strength:
            thrust_amount = fuel   # either way it's still the same
    speed_change = thrust_amount * POWER
    fuel_used = thrust_amount
    return speed_change,fuel_used

# ------------------------------------------------
# Function 2 - Function that updates the users with the new altitude and speed of the spaceship
def update_one_second(altitude,speed):
    '''
    Returns the altitude and speed of the spaceship given the initial altitude and initial speed
    Parameters:
        altitude: (float) - the initial altitude of the spaceship
        speed: (float) - the initial speed of the spaceship
    Returns:
        altitude: (float) - the final altitude of the spaceship
        speed: (float) - the final speed of the spaceship
    '''
    speed = speed + GRAVITY
    altitude = altitude - speed
    if altitude < 0:
        altitude = 0
    return altitude, speed

# ------------------------------------------------
# Function 3 - Function that reports the landing status of the spaceship
def report_landing(speed,strength):
    '''
    Prints the landing status of the spaceship given the final speed of the spaceship and the strength of the pilot
    Parameters:
        speed: (float) - the final speed of the spaceship upon landing
        strength: (int) - the strength of the pilot
    Return:
        True or False : (bool)
    '''
    if speed <= strength:
        print("The landing is a success! Congratulations!!")
        return True
    else:
        print("You just crashed your spaceship! Bad luck this time!!")
        return False
        
# ------------------------------------------------
# Function 4 - Function that asks the user for a manual or automatic simulation
def get_manual_or_automatic():
    '''
    Returns either a 'm' for manual simulation or an 'a' for automatic simulation given an input of a 'm' or an 'a' respectively from the user
    Parameter:
        None
    Returns:
        response: (str) - 'm' or 'a'
    '''
    keep_going = True
    prompt = "Enter 'm' for manual mode or 'a' for automatic mode: "
    while keep_going:
        command = input(prompt)
        if command == "m" or command == "M":
            keep_going = False
            response = "m"
        elif command == "a" or command == "A":
            keep_going = False
            response = "a"
    return response

# ------------------------------------------------
# Function 5 - Function that shows the status of the lander's altitude, speed, fuel and strength
def show_status(altitude,speed,fuel,strength):
    '''
    Prints the lander's status given the altitude, speed, fuel and strength
    Parameters:
        altitude: (float) - lander's altitude
        speed: (float) - lander's speed
        fuel: (int) - lander's fuel left
        strength: (int) - lander's strength
    Return:
        None
    '''
    altitude = round(float(altitude),2)
    speed = round(float(speed),2)
    fuel = int(fuel)
    strength = int(strength)
    print("Altitude =", altitude, "Velocity =", speed, "Fuel left =", fuel, "Pilot's strength =", strength)

# ------------------------------------------------
# Function 6 - Function that asks the user for the thrust value
def get_thrust_from_user(altitude,speed,fuel,strength):
    '''
    Returns the thrust value given an input of the thrust value from the user
    Parameters:
        altitude: (float) - lander's altitude
        speed: (float) - lander's speed
        fuel: (int) - lander's fuel left
        strength: (int) - lander's strength
    Return:
        thrust_value: (int) - value of thrust
    '''
    keep_going = True
    while keep_going:
        prompt = "Enter a thrust value: "
        thrust_value = input(prompt)
        if thrust_value == "":
            keep_going = True
        elif int(thrust_value) >= 0 and int(thrust_value) <= fuel and int(thrust_value) <= strength:
            keep_going = False
            return int(thrust_value)
    
# ------------------------------------------------
# Function 7 - Function that generates thrust value automatically
def auto_generate_thrust(altitude,speed,fuel,strength):
    '''
    Returns the thrust value based on the current speed of the spaceship and fuel left in the spaceship
    Parameters:
        altitude: (float) - lander's altitude
        speed: (float) - lander's speed
        fuel: (int) - lander's fuel left
        strength: (int) - lander's strength
    Return:
        thrust_value: (int) - value of thrust generated automatically
    '''
    thrust_value = 0
    
    if altitude == 30 and speed == 100:
        if fuel > strength:
            thrust_value = strength
        elif fuel < strength:
            thrust_value = fuel
        elif fuel == strength:
            thrust_value = fuel
            
    # if the current speed is still high and still has a lot of fuel left
    elif speed >= 30 and fuel > 10:
        thrust_value = 4
        
    # if the spaceship almost lands and has a current speed in between 20 and 30 (rough estimation)
    elif speed <= 30 and speed > 20:
        thrust_value = 3
        
    # if the spaceship almost lands and has a current speed in between 10 and 20 (rough estimation)
    elif speed <= 20 and speed > 10:
        thrust_value = 2
        
    # if the spaceship almost lands and has a current speed in between 3 and 10
    # purposely set in between 3 and 10 and not in between 0 and 10 because no thrust should be applied...
    # ... if it almost lands and has a speed of less than the strength (strength = 4 in all cases)
    elif speed <= 10 and speed > 3:
        thrust_value = 1
    
    # if the spaceship almost lands and has a current speed of less than the pilot's strength
    elif speed <= 3 and speed > 0:
        thrust_value = 0
        
    return thrust_value

# ------------------------------------------------
# Function 8 - Function that run through manual simulation of the spaceship        
def manual_simulation():
    '''
    Displays the altitude and speed of the spaceship, fuel left, and strength of the pilot every second 
    Parameter:
        None
    Return:
        None
    '''
    current_altitude = ALT_INIT 
    current_speed = SPEED_INIT
    current_fuel = FUEL_INIT
    pilot_strength = STRENGTH_INIT
    # assigning the constants to a new set of variables because the constants value can be different for other cases
    
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
            
    report_landing(current_speed,pilot_strength)
    # display the landing status of the spaceship at the end to the user

# ------------------------------------------------
# Function 9 - Function that run through automatic simulation of the spaceship    
def automatic_simulation():
    '''
    Displays the altitude and speed of the spaceship, fuel left, and strength of the pilot every second 
    Parameter:
        None
    Return:
        None
    '''
    current_altitude = ALT_INIT 
    current_speed = SPEED_INIT
    current_fuel = FUEL_INIT
    pilot_strength = STRENGTH_INIT
    current_power = POWER
    # assigning the constants to a new set of variables because the constants value can be different for other cases
    
    show_status(current_altitude,current_speed,current_fuel,pilot_strength)
    # display the initial status for all of the following variables to the user
    
    while current_altitude > 0: 
    # indicates that the spaceship still in the air, and will stop the loop when it has landed
    
        current_thrust_amount = auto_generate_thrust(current_altitude,current_speed,current_fuel,pilot_strength)
        # automatically generates a thrust value from auto_generate_thrust function and assigned it to a new variable named current_thrust_amount
        
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
            
    report_landing(current_speed,pilot_strength)
    # display the landing status of the spaceship at the end to the user

# ------------------------------------------------
# Function 10 - Function that controls the entire simulation
def main():
    '''
    Controls the entire simulation and asks the user for either a manual or automatic simulation
    Parameter: 
        None
    Return:
        None
    '''
    print("Hello, there!!! Welcome to my Spaceship simulator!! Please choose a simulation mode to start.")
    # greets the user at the start of the game
    
    response = get_manual_or_automatic()
    if response == 'm':
        manual_simulation()
    elif response == "a":          
        automatic_simulation()
    
    print("Thank you for playing. Have a great day!!") 
    # message to the user after the end of the game
main()