#Heun Function
###### Heun uses huens methoud to evaluate a function based on the derivative and displays a plot of t and y variables
###Inputs:
######dydt - function of the derivative for the anonymous function to
######evaluate ie f(t,y)
######tspan - an array containing initial and final values of t ie [0 2.1]
######y0 - intial y value of the function
######h - step size
######es - stopping error percent, defaults to .001%
######maxit - maximum iterations, defaults to 50
###Outputs:
######t - t value of final output
######y - y value of final output
