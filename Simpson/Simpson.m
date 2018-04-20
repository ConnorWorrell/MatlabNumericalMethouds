function I = Simpson(x,y)
%Simson Fuction uses simpsons 1/3 rule to integrate a list of equally spaced x and y
%values, last section will be integrated by trapazoidal methoud if needed
%   Inputs:
%      x - Array containing x values
%      y - Array containing y values
%   Outputs:
%      I - Value of integral

I=0;
EndBit=0;

%Check to see if x and y have same number of numbers
if(length(x) ~= length(y))
    error('Inputs need to be the same length');
end

%Check to see if x is evenly spaced
A=diff(x);
if(~(range(A) < .00000000001 && range(A) > -.00000000001))
    error('Inputs must be equally spaced');
end

%Check to see if trapazoidal rule needs to be used
if(rem(length(x),2)==0)
    warning('trapazoidal rule has to be used on the last interval');
    
    %Remove last number from each matrix
    Lasty = y(length(y)-1:length(y));
    x = x(1:length(x)-1);
    y = y(1:length(y)-1);
    
    %Do trapazoidal rule
    EndBit = ((Lasty(1)+ Lasty(2))/2)*A(1);
end

%use simpsons 1/3 rule to calulate area
for i = 1:(length(x)-1)/2
    I = I + (A(1)/3)*(y(i*2-1) + 4*y(i*2) + y(i*2+1));
end

%add simpsons 1/3 rule to trapazoidal rule
I=I+EndBit;




