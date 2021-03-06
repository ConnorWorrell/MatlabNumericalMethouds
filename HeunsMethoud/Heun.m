function [t,y] = Heun(dydt, tspan, y0, h, es, maxit)
%Heun uses huens methoud to evaluate a function based on the derivative and
%displays a plot of t and y variables
% Inputs:
%   dydt - function of the derivative for the anonymous function to
%   evaluate ie f(t,y)
%   tspan - an array containing initial and final values of t ie [0 2.1]
%   y0 - intial y value of the function
%   h - step size
%   es - stopping error percent, defaults to .001%
%   maxit - maximum iterations, defaults to 50
% Outputs:
%   t - t value of final output
%   y - y value of final output

%close all;
%ode45(dydt,tspan,y0);

%Make sure the minimum nuber of inputs are used
if(nargin < 4)
    error('At least 4 values need to be input');
end
%Assign es if it needs to default
if(nargin < 5)
    es = .001;
end
%Assign maxit if it needs to be defaulted
if(nargin < 6)
    maxit = 50;
end

if(tspan(1) >= tspan(2))
    error('Tspan needs to have different numbers where the first number is smaller than the second');
end

%Record Number of things to evaluate, cuts off the last span if it dosent
%fit in h
temp = (tspan(1):h:tspan(2));

%Check if last tspan value dosent fit in h
if(rem(tspan(2),h)~=0)
    warning('h does not divide evely into TStep')
    LastBit = tspan(2);%Record Last Number, will be replaced later
    tspan(2) = temp(length(temp));%Replace last number with a number that matches step size
end

hold on

yvalues(1) = y0;

Error = es + 1;%guarentee that we iterate each point once
Iter = 0;
y = y0;
for t = temp(1:length(temp)-1)
    SlopeLeft = dydt(t,y);
    AvgSlope = SlopeLeft;
    LstAvgSlp = AvgSlope*10000;
    while(Error > es && Iter < maxit)
        SlopeRight = dydt(t+h,y+AvgSlope*h);
        AvgSlope = (1/2)*(SlopeRight + SlopeLeft);
        Iter = Iter + 1;
        Error = abs((AvgSlope - LstAvgSlp)/AvgSlope)*100;
        LstAvgSlp = AvgSlope;
        %fprintf("Left: %.3f Right: %.3f Avg: %.3f Iter: %.0f Error: %.5f\n", SlopeLeft, SlopeRight, AvgSlope, Iter, Error);
        fprintf("t: %.2f y: %.2f\n", t+h, y+AvgSlope*h);
        %plot(t+h,y+AvgSlope*h,'*')
    end
    y = y + AvgSlope*h;
    Error = es + 1;
    Iter = 0;
    
    yvalues(length(yvalues)+1)=y;
end

if(exist('LastBit','var'))
    t = temp(length(temp));
    h = LastBit - temp(length(temp));
    SlopeLeft = dydt(t,y);
    AvgSlope = SlopeLeft;
    LstAvgSlp = AvgSlope*10000;
    while(Error > es && Iter < maxit)
        SlopeRight = dydt(t+h,y+AvgSlope*h);
        AvgSlope = (1/2)*(SlopeRight + SlopeLeft);
        Iter = Iter + 1;
        Error = abs((AvgSlope - LstAvgSlp)/AvgSlope)*100;
        LstAvgSlp = AvgSlope;
        %fprintf("Left: %.3f Right: %.3f Avg: %.3f Iter: %.0f Error: %.5f\n", SlopeLeft, SlopeRight, AvgSlope, Iter, Error);
        fprintf("t: %.2f y: %.2f\n", t+h, y+AvgSlope*h);
        %plot(t+h,y+AvgSlope*h,'*')
    end
    y = y + AvgSlope*h;
    yvalues(length(yvalues)+1) = y;
    temp(length(temp)+1) = LastBit;
end

t = temp;
y = yvalues;

plot(t,y);

hold off

end

